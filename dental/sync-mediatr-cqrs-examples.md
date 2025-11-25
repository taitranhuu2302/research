# MediatR CQRS Implementation Examples - PMS Sync

## 📋 Tổng Quan

Tài liệu này cung cấp code examples cho PMS Sync module sử dụng **MediatR CQRS pattern** thay vì Application Services trực tiếp.

---

## 🏗️ Kiến Trúc MediatR CQRS

```
Service Bus Consumer
    ↓
ProcessWebhookCommand (Orchestrator)
    ↓
    ├─→ ExtractDataCommand
    ├─→ LoadDataCommand
    └─→ TransformDataCommand
        ├─→ SyncPatientCommand
        ├─→ SyncAppointmentCommand
        └─→ SyncTreatmentPlanCommand
```

---

## 📦 Commands

### **1. ProcessWebhookCommand (Orchestrator)**

```csharp
using MediatR;
using Dental.PmsSync.Application.DTOs;

namespace Dental.PmsSync.Application.Commands.ProcessWebhook;

public class ProcessWebhookCommand : IRequest<SyncResult>
{
    public string Payload { get; set; }
    public string? WebhookUrl { get; set; }
    public string? CorrelationId { get; set; }
    public DateTime ReceivedAt { get; set; }
}

public class ProcessWebhookCommandHandler 
    : IRequestHandler<ProcessWebhookCommand, SyncResult>
{
    private readonly IMediator _mediator;
    private readonly ILogger<ProcessWebhookCommandHandler> _logger;

    public ProcessWebhookCommandHandler(
        IMediator mediator,
        ILogger<ProcessWebhookCommandHandler> logger)
    {
        _mediator = mediator;
        _logger = logger;
    }

    public async Task<SyncResult> Handle(
        ProcessWebhookCommand request, 
        CancellationToken cancellationToken)
    {
        var correlationId = request.CorrelationId ?? Guid.NewGuid().ToString();
        var startTime = DateTime.UtcNow;

        try
        {
            _logger.LogInformation(
                "Processing webhook. CorrelationId: {CorrelationId}",
                correlationId);

            // 1. Get PMS connection (Query)
            var connectionQuery = new GetPmsConnectionByWebhookUrlQuery
            {
                WebhookUrl = request.WebhookUrl
            };
            var connection = await _mediator.Send(connectionQuery, cancellationToken);

            if (connection == null || !connection.IsActive)
            {
                throw new PmsConnectionNotFoundException(
                    $"PMS connection not found or inactive for webhook: {request.WebhookUrl}");
            }

            // 2. EXTRACT (Command)
            var extractCommand = new ExtractDataCommand
            {
                RawJsonPayload = request.Payload,
                PmsType = connection.PmsType,
                EntityType = DetermineEntityType(request.Payload)
            };
            var extractedData = await _mediator.Send(extractCommand, cancellationToken);

            // 3. LOAD (Command)
            var loadCommand = new LoadDataCommand
            {
                TenantId = connection.TenantId,
                PmsConnectionId = connection.Id,
                PmsType = connection.PmsType,
                EntityType = extractCommand.EntityType,
                RawJsonPayload = request.Payload,
                ExtractedData = extractedData,
                CorrelationId = correlationId
            };
            var rawData = await _mediator.Send(loadCommand, cancellationToken);

            // 4. TRANSFORM (Command)
            var transformCommand = new TransformDataCommand
            {
                RawData = rawData,
                ExtractedData = extractedData
            };
            var transformResult = await _mediator.Send(transformCommand, cancellationToken);

            // 5. Update raw data status
            rawData.MarkAsCompleted(transformResult.EntityId, transformResult.EntityType);
            await _rawDataRepository.UpdateAsync(rawData, cancellationToken);

            var duration = DateTime.UtcNow - startTime;
            _logger.LogInformation(
                "Successfully processed webhook. CorrelationId: {CorrelationId}, Duration: {Duration}ms",
                correlationId,
                duration.TotalMilliseconds);

            return new SyncResult
            {
                Success = true,
                CorrelationId = correlationId,
                EntityId = transformResult.EntityId,
                EntityType = transformResult.EntityType
            };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex,
                "Failed to process webhook. CorrelationId: {CorrelationId}",
                correlationId);

            return new SyncResult
            {
                Success = false,
                CorrelationId = correlationId,
                ErrorMessage = ex.Message
            };
        }
    }

    private SyncEntityType DetermineEntityType(string payload)
    {
        // Simple logic to determine entity type from payload
        // Can be enhanced with JSON schema validation
        if (payload.Contains("\"PatNum\"") || payload.Contains("\"patient\""))
            return SyncEntityType.Patient;
        
        if (payload.Contains("\"AptNum\"") || payload.Contains("\"appointment\""))
            return SyncEntityType.Appointment;
        
        if (payload.Contains("\"TreatPlanNum\"") || payload.Contains("\"treatmentPlan\""))
            return SyncEntityType.TreatmentPlan;

        throw new InvalidOperationException("Cannot determine entity type from payload");
    }
}
```

---

### **2. ExtractDataCommand**

```csharp
using MediatR;
using Dental.PmsSync.Application.Adapters;
using Dental.PmsSync.Application.DTOs;
using Dental.PmsSync.Domain.Enums;

namespace Dental.PmsSync.Application.Commands.ExtractData;

public class ExtractDataCommand : IRequest<RawDataDto>
{
    public string RawJsonPayload { get; set; }
    public PmsType PmsType { get; set; }
    public SyncEntityType EntityType { get; set; }
}

public class ExtractDataCommandHandler 
    : IRequestHandler<ExtractDataCommand, RawDataDto>
{
    private readonly IPmsAdapterFactory _adapterFactory;
    private readonly ILogger<ExtractDataCommandHandler> _logger;

    public ExtractDataCommandHandler(
        IPmsAdapterFactory adapterFactory,
        ILogger<ExtractDataCommandHandler> logger)
    {
        _adapterFactory = adapterFactory;
        _logger = logger;
    }

    public async Task<RawDataDto> Handle(
        ExtractDataCommand request, 
        CancellationToken cancellationToken)
    {
        _logger.LogDebug(
            "Extracting data. PmsType: {PmsType}, EntityType: {EntityType}",
            request.PmsType,
            request.EntityType);

        var adapter = _adapterFactory.GetAdapter(request.PmsType);

        // Validate payload
        var isValid = await adapter.ValidatePayloadAsync(
            request.RawJsonPayload, 
            request.EntityType);
        
        if (!isValid)
        {
            throw new InvalidPayloadException(
                $"Invalid payload schema for {request.PmsType} - {request.EntityType}");
        }

        // Extract to structured data
        var rawData = await adapter.ExtractAsync(
            request.RawJsonPayload, 
            request.EntityType);

        _logger.LogDebug(
            "Successfully extracted data. PmsEntityId: {PmsEntityId}",
            rawData.PmsEntityId);

        return rawData;
    }
}
```

---

### **3. LoadDataCommand**

```csharp
using MediatR;
using System.Text.Json;
using Dental.PmsSync.Application.DTOs;
using Dental.PmsSync.Domain.Entities;
using Dental.PmsSync.Domain.Enums;

namespace Dental.PmsSync.Application.Commands.LoadData;

public class LoadDataCommand : IRequest<PmsRawData>
{
    public Guid TenantId { get; set; }
    public Guid PmsConnectionId { get; set; }
    public PmsType PmsType { get; set; }
    public SyncEntityType EntityType { get; set; }
    public SyncOperation Operation { get; set; }
    public string RawJsonPayload { get; set; }
    public RawDataDto ExtractedData { get; set; }
    public string CorrelationId { get; set; }
}

public class LoadDataCommandHandler 
    : IRequestHandler<LoadDataCommand, PmsRawData>
{
    private readonly IPmsRawDataRepository _rawDataRepository;
    private readonly ILogger<LoadDataCommandHandler> _logger;

    public LoadDataCommandHandler(
        IPmsRawDataRepository rawDataRepository,
        ILogger<LoadDataCommandHandler> logger)
    {
        _rawDataRepository = rawDataRepository;
        _logger = logger;
    }

    public async Task<PmsRawData> Handle(
        LoadDataCommand request, 
        CancellationToken cancellationToken)
    {
        _logger.LogDebug(
            "Loading data to landing zone. CorrelationId: {CorrelationId}, PmsEntityId: {PmsEntityId}",
            request.CorrelationId,
            request.ExtractedData.PmsEntityId);

        // Idempotency check by message ID
        if (!string.IsNullOrEmpty(request.ExtractedData.PmsMessageId))
        {
            var existingByMessageId = await _rawDataRepository.FindByMessageIdAsync(
                request.PmsConnectionId,
                request.ExtractedData.PmsMessageId,
                cancellationToken);

            if (existingByMessageId != null)
            {
                _logger.LogInformation(
                    "Message {MessageId} already processed. Returning existing record.",
                    request.ExtractedData.PmsMessageId);
                return existingByMessageId;
            }
        }

        // Idempotency check by entity ID + operation
        var existingByEntity = await _rawDataRepository.FindByEntityIdAsync(
            request.PmsConnectionId,
            request.EntityType,
            request.ExtractedData.PmsEntityId,
            request.ExtractedData.Operation,
            cancellationToken);

        if (existingByEntity != null)
        {
            if (existingByEntity.Status == SyncStatus.Completed)
            {
                throw new DuplicateSyncException(
                    $"Entity {request.ExtractedData.PmsEntityId} with operation {request.ExtractedData.Operation} already synced");
            }

            // Update existing pending/failed record
            existingByEntity.UpdateExtractedData(JsonSerializer.Serialize(request.ExtractedData));
            existingByEntity.MarkAsProcessing();
            await _rawDataRepository.UpdateAsync(existingByEntity, cancellationToken);
            
            _logger.LogInformation(
                "Updated existing raw data record. Id: {Id}",
                existingByEntity.Id);
            
            return existingByEntity;
        }

        // Create new raw data record
        var rawData = new PmsRawData(
            tenantId: request.TenantId,
            pmsConnectionId: request.PmsConnectionId,
            pmsType: request.PmsType,
            entityType: request.EntityType,
            operation: request.ExtractedData.Operation,
            rawJsonPayload: request.RawJsonPayload,
            extractedDataJson: JsonSerializer.Serialize(request.ExtractedData),
            pmsEntityId: request.ExtractedData.PmsEntityId,
            pmsMessageId: request.ExtractedData.PmsMessageId,
            correlationId: request.CorrelationId);

        rawData.MarkAsProcessing();
        await _rawDataRepository.InsertAsync(rawData, cancellationToken);

        _logger.LogInformation(
            "Created new raw data record. Id: {Id}, CorrelationId: {CorrelationId}",
            rawData.Id,
            request.CorrelationId);

        return rawData;
    }
}
```

---

### **4. TransformDataCommand**

```csharp
using MediatR;
using System.Text.Json;
using Dental.PmsSync.Application.DTOs;
using Dental.PmsSync.Domain.Entities;
using Dental.PmsSync.Domain.Enums;
using Volo.Abp.MultiTenancy;

namespace Dental.PmsSync.Application.Commands.TransformData;

public class TransformDataCommand : IRequest<TransformResult>
{
    public PmsRawData RawData { get; set; }
    public RawDataDto ExtractedData { get; set; }
}

public class TransformDataCommandHandler 
    : IRequestHandler<TransformDataCommand, TransformResult>
{
    private readonly IMediator _mediator;
    private readonly ICurrentTenant _currentTenant;
    private readonly ILogger<TransformDataCommandHandler> _logger;

    public TransformDataCommandHandler(
        IMediator mediator,
        ICurrentTenant currentTenant,
        ILogger<TransformDataCommandHandler> logger)
    {
        _mediator = mediator;
        _currentTenant = currentTenant;
        _logger = logger;
    }

    public async Task<TransformResult> Handle(
        TransformDataCommand request, 
        CancellationToken cancellationToken)
    {
        // Set tenant context
        using (_currentTenant.Change(request.RawData.TenantId))
        {
            _logger.LogDebug(
                "Transforming data. EntityType: {EntityType}, PmsEntityId: {PmsEntityId}",
                request.RawData.EntityType,
                request.RawData.PmsEntityId);

            return request.RawData.EntityType switch
            {
                SyncEntityType.Patient => await TransformPatientAsync(request, cancellationToken),
                SyncEntityType.Appointment => await TransformAppointmentAsync(request, cancellationToken),
                SyncEntityType.TreatmentPlan => await TransformTreatmentPlanAsync(request, cancellationToken),
                _ => throw new NotSupportedException($"Entity type {request.RawData.EntityType} not supported")
            };
        }
    }

    private async Task<TransformResult> TransformPatientAsync(
        TransformDataCommand request,
        CancellationToken cancellationToken)
    {
        var command = new SyncPatientCommand
        {
            RawData = request.RawData,
            ExtractedData = request.ExtractedData
        };

        return await _mediator.Send(command, cancellationToken);
    }

    private async Task<TransformResult> TransformAppointmentAsync(
        TransformDataCommand request,
        CancellationToken cancellationToken)
    {
        var command = new SyncAppointmentCommand
        {
            RawData = request.RawData,
            ExtractedData = request.ExtractedData
        };

        return await _mediator.Send(command, cancellationToken);
    }

    private async Task<TransformResult> TransformTreatmentPlanAsync(
        TransformDataCommand request,
        CancellationToken cancellationToken)
    {
        var command = new SyncTreatmentPlanCommand
        {
            RawData = request.RawData,
            ExtractedData = request.ExtractedData
        };

        return await _mediator.Send(command, cancellationToken);
    }
}
```

---

### **5. SyncPatientCommand**

```csharp
using MediatR;
using System.Text.Json;
using Dental.PmsSync.Application.DTOs;
using Dental.PmsSync.Domain.Entities;
using Dental.PmsSync.Domain.Enums;
using Dental.TreatmentTracker.Entities;
using Dental.TreatmentTracker.ValueObjects;

namespace Dental.PmsSync.Application.Commands.SyncPatient;

public class SyncPatientCommand : IRequest<TransformResult>
{
    public PmsRawData RawData { get; set; }
    public RawDataDto ExtractedData { get; set; }
}

public class SyncPatientCommandHandler 
    : IRequestHandler<SyncPatientCommand, TransformResult>
{
    private readonly IPmsEntityMappingRepository _mappingRepository;
    private readonly IPatientRepository _patientRepository;
    private readonly ILogger<SyncPatientCommandHandler> _logger;

    public SyncPatientCommandHandler(
        IPmsEntityMappingRepository mappingRepository,
        IPatientRepository patientRepository,
        ILogger<SyncPatientCommandHandler> logger)
    {
        _mappingRepository = mappingRepository;
        _patientRepository = patientRepository;
        _logger = logger;
    }

    public async Task<TransformResult> Handle(
        SyncPatientCommand request, 
        CancellationToken cancellationToken)
    {
        var patientData = JsonSerializer.Deserialize<RawPatientData>(request.RawData.ExtractedDataJson);

        // Find or create entity mapping
        var mapping = await _mappingRepository.FindByPmsEntityIdAsync(
            request.RawData.PmsConnectionId,
            SyncEntityType.Patient,
            patientData.PmsEntityId,
            cancellationToken);

        Patient patient;

        if (mapping != null)
        {
            // Update existing
            _logger.LogDebug(
                "Updating existing patient. TenantEntityId: {TenantEntityId}",
                mapping.TenantEntityId);

            patient = await _patientRepository.GetAsync(mapping.TenantEntityId, cancellationToken: cancellationToken);

            var domainPatientData = MapToDomainPatientData(patientData);
            patient.Modify(domainPatientData);
            patient.LatestPmsSync = DateTime.UtcNow;

            await _patientRepository.UpdateAsync(patient, cancellationToken: cancellationToken);

            // Update mapping
            mapping.UpdateSyncHash(CalculateHash(patientData));
            await _mappingRepository.UpdateAsync(mapping, cancellationToken: cancellationToken);
        }
        else
        {
            // Create new
            _logger.LogDebug(
                "Creating new patient. PmsEntityId: {PmsEntityId}",
                patientData.PmsEntityId);

            var domainPatientData = MapToDomainPatientData(patientData);
            patient = new Patient(domainPatientData, patientData.PmsEntityId, request.RawData.TenantId);
            patient.LatestPmsSync = DateTime.UtcNow;

            await _patientRepository.InsertAsync(patient, cancellationToken: cancellationToken);

            // Create mapping
            mapping = new PmsEntityMapping(
                pmsConnectionId: request.RawData.PmsConnectionId,
                entityType: SyncEntityType.Patient,
                pmsEntityId: patientData.PmsEntityId,
                tenantEntityId: patient.Id);

            await _mappingRepository.InsertAsync(mapping, cancellationToken: cancellationToken);
        }

        _logger.LogInformation(
            "Successfully synced patient. PatientId: {PatientId}, PmsEntityId: {PmsEntityId}",
            patient.Id,
            patientData.PmsEntityId);

        return new TransformResult
        {
            EntityId = patient.Id,
            EntityType = nameof(Patient),
            MappingId = mapping.Id
        };
    }

    private PatientData MapToDomainPatientData(RawPatientData raw)
    {
        return new PatientData(
            patientPmsId: raw.PmsEntityId,
            avatarUrl: null,
            name: raw.Name,
            marketingSource: null,
            dateOfBirth: raw.DateOfBirth,
            haveInsurance: null,
            insuranceCompany: null,
            phoneNumber: raw.PhoneNumber,
            zipCode: raw.ZipCode,
            gender: raw.Gender,
            maritalStatus: null,
            spouseName: null,
            haveChildren: null,
            haveGrandchildren: null,
            occupation: null,
            hobbies: null,
            referralName: null);
    }

    private string CalculateHash(RawPatientData data)
    {
        // Calculate hash for change detection
        // Implementation depends on requirements
        return data.GetHashCode().ToString();
    }
}
```

---

## 🔍 Queries

### **1. GetPmsConnectionByWebhookUrlQuery**

```csharp
using MediatR;
using Dental.PmsSync.Domain.Entities;

namespace Dental.PmsSync.Application.Queries.GetPmsConnection;

public class GetPmsConnectionByWebhookUrlQuery : IRequest<PmsConnection>
{
    public string WebhookUrl { get; set; }
}

public class GetPmsConnectionByWebhookUrlQueryHandler 
    : IRequestHandler<GetPmsConnectionByWebhookUrlQuery, PmsConnection>
{
    private readonly IPmsConnectionRepository _connectionRepository;

    public GetPmsConnectionByWebhookUrlQueryHandler(
        IPmsConnectionRepository connectionRepository)
    {
        _connectionRepository = connectionRepository;
    }

    public async Task<PmsConnection> Handle(
        GetPmsConnectionByWebhookUrlQuery request, 
        CancellationToken cancellationToken)
    {
        return await _connectionRepository.GetByWebhookUrlAsync(
            request.WebhookUrl, 
            cancellationToken);
    }
}
```

---

## 🔧 Pipeline Behaviors

### **1. ValidationBehavior**

```csharp
using FluentValidation;
using MediatR;

namespace Dental.PmsSync.Application.Behaviors;

public class ValidationBehavior<TRequest, TResponse> 
    : IPipelineBehavior<TRequest, TResponse>
    where TRequest : IRequest<TResponse>
{
    private readonly IEnumerable<IValidator<TRequest>> _validators;
    private readonly ILogger<ValidationBehavior<TRequest, TResponse>> _logger;

    public ValidationBehavior(
        IEnumerable<IValidator<TRequest>> validators,
        ILogger<ValidationBehavior<TRequest, TResponse>> logger)
    {
        _validators = validators;
        _logger = logger;
    }

    public async Task<TResponse> Handle(
        TRequest request, 
        RequestHandlerDelegate<TResponse> next, 
        CancellationToken cancellationToken)
    {
        if (_validators.Any())
        {
            var context = new ValidationContext<TRequest>(request);

            var validationResults = await Task.WhenAll(
                _validators.Select(v => v.ValidateAsync(context, cancellationToken)));

            var failures = validationResults
                .SelectMany(r => r.Errors)
                .Where(f => f != null)
                .ToList();

            if (failures.Any())
            {
                _logger.LogWarning(
                    "Validation failed for {RequestType}. Errors: {Errors}",
                    typeof(TRequest).Name,
                    string.Join(", ", failures.Select(f => f.ErrorMessage)));

                throw new ValidationException(failures);
            }
        }

        return await next();
    }
}
```

### **2. LoggingBehavior**

```csharp
using MediatR;
using System.Diagnostics;

namespace Dental.PmsSync.Application.Behaviors;

public class LoggingBehavior<TRequest, TResponse> 
    : IPipelineBehavior<TRequest, TResponse>
    where TRequest : IRequest<TResponse>
{
    private readonly ILogger<LoggingBehavior<TRequest, TResponse>> _logger;

    public LoggingBehavior(ILogger<LoggingBehavior<TRequest, TResponse>> logger)
    {
        _logger = logger;
    }

    public async Task<TResponse> Handle(
        TRequest request, 
        RequestHandlerDelegate<TResponse> next, 
        CancellationToken cancellationToken)
    {
        var requestName = typeof(TRequest).Name;
        var stopwatch = Stopwatch.StartNew();

        _logger.LogInformation(
            "Handling {RequestName}. Request: {@Request}",
            requestName,
            request);

        try
        {
            var response = await next();

            stopwatch.Stop();
            _logger.LogInformation(
                "Handled {RequestName}. Duration: {Duration}ms. Response: {@Response}",
                requestName,
                stopwatch.ElapsedMilliseconds,
                response);

            return response;
        }
        catch (Exception ex)
        {
            stopwatch.Stop();
            _logger.LogError(ex,
                "Error handling {RequestName}. Duration: {Duration}ms",
                requestName,
                stopwatch.ElapsedMilliseconds);

            throw;
        }
    }
}
```

### **3. TransactionBehavior**

```csharp
using MediatR;
using Volo.Abp.Uow;

namespace Dental.PmsSync.Application.Behaviors;

public class TransactionBehavior<TRequest, TResponse> 
    : IPipelineBehavior<TRequest, TResponse>
    where TRequest : IRequest<TResponse>
{
    private readonly IUnitOfWorkManager _unitOfWorkManager;

    public TransactionBehavior(IUnitOfWorkManager unitOfWorkManager)
    {
        _unitOfWorkManager = unitOfWorkManager;
    }

    public async Task<TResponse> Handle(
        TRequest request, 
        RequestHandlerDelegate<TResponse> next, 
        CancellationToken cancellationToken)
    {
        // Check if request requires transaction
        if (request is ITransactionalRequest)
        {
            using var uow = _unitOfWorkManager.Begin();
            var response = await next();
            await uow.CompleteAsync(cancellationToken);
            return response;
        }

        return await next();
    }
}

// Marker interface for commands that require transaction
public interface ITransactionalRequest : IRequest
{
}
```

---

## 🚀 Service Bus Consumer (Updated)

```csharp
using System.Text.Json;
using Azure.Messaging.ServiceBus;
using MediatR;
using Dental.PmsSync.Application.Commands.ProcessWebhook;
using Dental.PmsSync.Application.DTOs;

namespace Dental.PmsSync.Application.BackgroundWorkers;

public class ServiceBusConsumerWorker : AsyncPeriodicBackgroundWorkerBase
{
    private readonly ServiceBusClient _serviceBusClient;
    private readonly IMediator _mediator;
    private ServiceBusProcessor? _processor;

    public ServiceBusConsumerWorker(
        AbpAsyncTimer timer,
        IServiceScopeFactory serviceScopeFactory,
        ServiceBusClient serviceBusClient,
        IMediator mediator)
        : base(timer, serviceScopeFactory)
    {
        _serviceBusClient = serviceBusClient;
        _mediator = mediator;
        Timer.Period = 60000; // 1 minute
    }

    protected override async Task DoWorkAsync(PeriodicBackgroundWorkerContext workerContext)
    {
        if (_processor == null)
        {
            var options = new ServiceBusProcessorOptions
            {
                MaxConcurrentCalls = 5,
                AutoCompleteMessages = false,
                PrefetchCount = 0
            };

            _processor = _serviceBusClient.CreateProcessor(
                "pms-webhook-events",
                "pms-sync-processor",
                options);

            _processor.ProcessMessageAsync += ProcessMessageAsync;
            _processor.ProcessErrorAsync += ProcessErrorAsync;

            await _processor.StartProcessingAsync();
        }
    }

    private async Task ProcessMessageAsync(ProcessMessageEventArgs args)
    {
        using var scope = ServiceProvider.CreateScope();
        var mediator = scope.ServiceProvider.GetRequiredService<IMediator>();
        var logger = scope.ServiceProvider.GetRequiredService<ILogger<ServiceBusConsumerWorker>>();

        try
        {
            var messageBody = args.Message.Body.ToString();
            var message = JsonSerializer.Deserialize<WebhookMessageDto>(messageBody);

            logger.LogInformation(
                "Processing webhook message. CorrelationId: {CorrelationId}",
                message.CorrelationId);

            var command = new ProcessWebhookCommand
            {
                Payload = message.Payload,
                WebhookUrl = message.WebhookUrl,
                CorrelationId = message.CorrelationId,
                ReceivedAt = message.ReceivedAt
            };

            var result = await mediator.Send(command);

            if (result.Success)
            {
                await args.CompleteMessageAsync(args.Message);
                logger.LogInformation(
                    "Successfully processed webhook. CorrelationId: {CorrelationId}",
                    message.CorrelationId);
            }
            else
            {
                await args.AbandonMessageAsync(args.Message);
                logger.LogWarning(
                    "Failed to process webhook. CorrelationId: {CorrelationId}, Error: {Error}",
                    message.CorrelationId,
                    result.ErrorMessage);
            }
        }
        catch (Exception ex)
        {
            logger.LogError(ex,
                "Error processing webhook message. MessageId: {MessageId}",
                args.Message.MessageId);

            await args.AbandonMessageAsync(args.Message);
        }
    }

    private Task ProcessErrorAsync(ProcessErrorEventArgs args)
    {
        var logger = ServiceProvider.GetRequiredService<ILogger<ServiceBusConsumerWorker>>();
        logger.LogError(args.Exception,
            "Service Bus error. ErrorSource: {ErrorSource}",
            args.ErrorSource);

        return Task.CompletedTask;
    }
}
```

---

## ⚙️ Module Configuration

```csharp
using MediatR;
using FluentValidation;
using Microsoft.Extensions.DependencyInjection;
using Volo.Abp.Modularity;

namespace Dental.PmsSync;

[DependsOn(
    typeof(AbpBackgroundWorkersModule),
    typeof(AbpMultiTenancyModule))]
public class PmsSyncModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        var services = context.Services;
        var configuration = context.Services.GetConfiguration();

        // MediatR
        services.AddMediatR(cfg =>
        {
            cfg.RegisterServicesFromAssembly(typeof(PmsSyncModule).Assembly);
        });

        // Pipeline Behaviors
        services.AddTransient(typeof(IPipelineBehavior<,>), typeof(ValidationBehavior<,>));
        services.AddTransient(typeof(IPipelineBehavior<,>), typeof(LoggingBehavior<,>));
        services.AddTransient(typeof(IPipelineBehavior<,>), typeof(TransactionBehavior<,>));

        // FluentValidation
        services.AddValidatorsFromAssembly(typeof(PmsSyncModule).Assembly);

        // Service Bus
        services.AddSingleton(sp =>
        {
            var connectionString = configuration["Azure:ServiceBus:ConnectionString"];
            return new ServiceBusClient(connectionString);
        });

        // Register adapters
        services.AddTransient<IPmsAdapter, OpenDentalAdapter>();
        services.AddTransient<IPmsAdapterFactory, PmsAdapterFactory>();

        // Register repositories
        services.AddTransient<IPmsRawDataRepository, PmsRawDataRepository>();
        services.AddTransient<IPmsConnectionRepository, PmsConnectionRepository>();
        services.AddTransient<IPmsEntityMappingRepository, PmsEntityMappingRepository>();

        // Register background worker
        services.AddSingleton<ServiceBusConsumerWorker>();
    }
}
```

---

## ✅ Benefits của MediatR CQRS

1. **Separation of Concerns**: Commands/Queries tách biệt rõ ràng
2. **Testability**: Dễ test từng handler độc lập
3. **Pipeline Behaviors**: Validation, logging, transaction management
4. **Flexibility**: Dễ thêm behaviors (caching, retry, etc.)
5. **Maintainability**: Code dễ đọc và maintain
6. **Scalability**: Có thể scale handlers độc lập

---

## 📝 Validation Examples

### **ProcessWebhookCommandValidator**

```csharp
using FluentValidation;

namespace Dental.PmsSync.Application.Commands.ProcessWebhook;

public class ProcessWebhookCommandValidator : AbstractValidator<ProcessWebhookCommand>
{
    public ProcessWebhookCommandValidator()
    {
        RuleFor(x => x.Payload)
            .NotEmpty()
            .WithMessage("Payload is required");

        RuleFor(x => x.WebhookUrl)
            .NotEmpty()
            .WithMessage("Webhook URL is required")
            .Must(BeValidUrl)
            .WithMessage("Webhook URL must be a valid URL");

        RuleFor(x => x.ReceivedAt)
            .NotEmpty()
            .WithMessage("ReceivedAt is required");
    }

    private bool BeValidUrl(string url)
    {
        return Uri.TryCreate(url, UriKind.Absolute, out _);
    }
}
```

---

## 🎯 Kết Luận

Với MediatR CQRS pattern:
- ✅ Code structure rõ ràng và maintainable
- ✅ Dễ test và debug
- ✅ Pipeline behaviors cho cross-cutting concerns
- ✅ Separation of concerns tốt hơn
- ✅ Dễ extend và scale

