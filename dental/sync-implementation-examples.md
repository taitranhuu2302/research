# Code Examples - PMS Sync Implementation

## 📋 Mục Lục

1. [Entity Definitions](#entity-definitions)
2. [Adapter Implementation](#adapter-implementation)
3. [ELT Services](#elt-services)
4. [Service Bus Consumer](#service-bus-consumer)
5. [Configuration](#configuration)

---

## Entity Definitions

### **PmsConnection.cs**

```csharp
using System;
using System.Collections.Generic;
using Volo.Abp.Domain.Entities.Auditing;

namespace Dental.PmsSync.Domain.Entities;

public class PmsConnection : FullAuditedAggregateRoot<Guid>
{
    private PmsConnection() { }

    public PmsConnection(
        Guid tenantId,
        PmsType pmsType,
        string connectionName,
        string webhookUrl,
        string webhookSecret)
    {
        TenantId = tenantId;
        PmsType = pmsType;
        ConnectionName = connectionName;
        WebhookUrl = webhookUrl;
        WebhookSecret = webhookSecret;
        IsActive = true;
        Settings = new Dictionary<string, string>();
        EntityMappings = new List<PmsEntityMapping>();
    }

    public Guid TenantId { get; private set; }
    public PmsType PmsType { get; private set; }
    public string ConnectionName { get; private set; }
    public string WebhookUrl { get; private set; }
    public string WebhookSecret { get; private set; }
    public bool IsActive { get; private set; }
    public Dictionary<string, string> Settings { get; private set; }
    
    public ICollection<PmsEntityMapping> EntityMappings { get; private set; }

    public void Deactivate()
    {
        IsActive = false;
    }

    public void Activate()
    {
        IsActive = true;
    }

    public void UpdateSettings(Dictionary<string, string> settings)
    {
        Settings = settings ?? new Dictionary<string, string>();
    }
}
```

### **PmsRawData.cs**

```csharp
using System;
using Volo.Abp.Domain.Entities.Auditing;

namespace Dental.PmsSync.Domain.Entities;

public class PmsRawData : FullAuditedAggregateRoot<Guid>
{
    private PmsRawData() { }

    public PmsRawData(
        Guid tenantId,
        Guid pmsConnectionId,
        PmsType pmsType,
        SyncEntityType entityType,
        SyncOperation operation,
        string rawJsonPayload,
        string? extractedDataJson,
        string pmsEntityId,
        string? pmsMessageId,
        string correlationId)
    {
        TenantId = tenantId;
        PmsConnectionId = pmsConnectionId;
        PmsType = pmsType;
        EntityType = entityType;
        Operation = operation;
        RawJsonPayload = rawJsonPayload;
        ExtractedDataJson = extractedDataJson;
        PmsEntityId = pmsEntityId;
        PmsMessageId = pmsMessageId;
        CorrelationId = correlationId;
        Status = SyncStatus.Pending;
        ReceivedAt = DateTime.UtcNow;
        RetryCount = 0;
    }

    public Guid TenantId { get; private set; }
    public Guid PmsConnectionId { get; private set; }
    public PmsConnection PmsConnection { get; private set; }
    
    public PmsType PmsType { get; private set; }
    public SyncEntityType EntityType { get; private set; }
    public SyncOperation Operation { get; private set; }
    
    public string RawJsonPayload { get; private set; }
    public string? ExtractedDataJson { get; private set; }
    
    public string PmsEntityId { get; private set; }
    public string? PmsMessageId { get; private set; }
    
    public SyncStatus Status { get; private set; }
    public DateTime? ProcessedAt { get; private set; }
    public string? ErrorMessage { get; private set; }
    public int RetryCount { get; private set; }
    
    public string CorrelationId { get; private set; }
    public DateTime ReceivedAt { get; private set; }
    
    public Guid? TransformedEntityId { get; private set; }
    public string? TransformedEntityType { get; private set; }

    public void MarkAsProcessing()
    {
        Status = SyncStatus.Processing;
    }

    public void MarkAsCompleted(Guid entityId, string entityType)
    {
        Status = SyncStatus.Completed;
        ProcessedAt = DateTime.UtcNow;
        TransformedEntityId = entityId;
        TransformedEntityType = entityType;
    }

    public void MarkAsFailed(string errorMessage)
    {
        Status = SyncStatus.Failed;
        ProcessedAt = DateTime.UtcNow;
        ErrorMessage = errorMessage;
        RetryCount++;
    }

    public void UpdateExtractedData(string extractedDataJson)
    {
        ExtractedDataJson = extractedDataJson;
    }
}
```

### **PmsEntityMapping.cs**

```csharp
using System;
using Volo.Abp.Domain.Entities.Auditing;

namespace Dental.PmsSync.Domain.Entities;

public class PmsEntityMapping : FullAuditedAggregateRoot<Guid>
{
    private PmsEntityMapping() { }

    public PmsEntityMapping(
        Guid pmsConnectionId,
        SyncEntityType entityType,
        string pmsEntityId,
        Guid tenantEntityId)
    {
        PmsConnectionId = pmsConnectionId;
        EntityType = entityType;
        PmsEntityId = pmsEntityId;
        TenantEntityId = tenantEntityId;
        LastSyncedAt = DateTime.UtcNow;
    }

    public Guid PmsConnectionId { get; private set; }
    public PmsConnection PmsConnection { get; private set; }
    
    public SyncEntityType EntityType { get; private set; }
    public string PmsEntityId { get; private set; }
    public Guid TenantEntityId { get; private set; }
    
    public DateTime LastSyncedAt { get; private set; }
    public string? LastSyncHash { get; private set; }

    public void UpdateSyncHash(string hash)
    {
        LastSyncHash = hash;
        LastSyncedAt = DateTime.UtcNow;
    }
}
```

---

## Adapter Implementation

### **IPmsAdapter.cs**

```csharp
using System.Threading.Tasks;
using Dental.PmsSync.Application.DTOs;

namespace Dental.PmsSync.Application.Adapters;

public interface IPmsAdapter
{
    PmsType PmsType { get; }
    
    Task<RawDataDto> ExtractAsync(string rawJsonPayload, SyncEntityType entityType);
    Task<bool> ValidatePayloadAsync(string rawJsonPayload, SyncEntityType entityType);
    string GetEntityId(string rawJsonPayload, SyncEntityType entityType);
    SyncOperation GetOperation(string rawJsonPayload, SyncEntityType entityType);
}
```

### **OpenDentalAdapter.cs**

```csharp
using System;
using System.Text.Json;
using System.Threading.Tasks;
using Dental.PmsSync.Application.DTOs;
using Dental.PmsSync.Domain.Enums;

namespace Dental.PmsSync.Application.Adapters;

public class OpenDentalAdapter : IPmsAdapter
{
    public PmsType PmsType => PmsType.OpenDental;

    public async Task<RawDataDto> ExtractAsync(string rawJsonPayload, SyncEntityType entityType)
    {
        return entityType switch
        {
            SyncEntityType.Patient => ExtractPatient(rawJsonPayload),
            SyncEntityType.Appointment => ExtractAppointment(rawJsonPayload),
            SyncEntityType.TreatmentPlan => ExtractTreatmentPlan(rawJsonPayload),
            _ => throw new NotSupportedException($"Entity type {entityType} not supported")
        };
    }

    public async Task<bool> ValidatePayloadAsync(string rawJsonPayload, SyncEntityType entityType)
    {
        try
        {
            var jsonDoc = JsonDocument.Parse(rawJsonPayload);
            
            return entityType switch
            {
                SyncEntityType.Patient => ValidatePatientPayload(jsonDoc),
                SyncEntityType.Appointment => ValidateAppointmentPayload(jsonDoc),
                SyncEntityType.TreatmentPlan => ValidateTreatmentPlanPayload(jsonDoc),
                _ => false
            };
        }
        catch
        {
            return false;
        }
    }

    public string GetEntityId(string rawJsonPayload, SyncEntityType entityType)
    {
        var jsonDoc = JsonDocument.Parse(rawJsonPayload);
        
        return entityType switch
        {
            SyncEntityType.Patient => jsonDoc.RootElement.GetProperty("PatNum").GetString(),
            SyncEntityType.Appointment => jsonDoc.RootElement.GetProperty("AptNum").GetString(),
            SyncEntityType.TreatmentPlan => jsonDoc.RootElement.GetProperty("TreatPlanNum").GetString(),
            _ => throw new NotSupportedException()
        };
    }

    public SyncOperation GetOperation(string rawJsonPayload, SyncEntityType entityType)
    {
        var jsonDoc = JsonDocument.Parse(rawJsonPayload);
        
        if (jsonDoc.RootElement.TryGetProperty("operation", out var operationElement))
        {
            var operation = operationElement.GetString();
            return operation switch
            {
                "create" => SyncOperation.Create,
                "update" => SyncOperation.Update,
                "delete" => SyncOperation.Delete,
                _ => SyncOperation.Update // Default
            };
        }
        
        // Default: Assume update if operation not specified
        return SyncOperation.Update;
    }

    private RawDataDto ExtractPatient(string json)
    {
        var payload = JsonSerializer.Deserialize<OpenDentalPatientPayload>(json);
        
        return new RawPatientData
        {
            PmsEntityId = payload.PatNum.ToString(),
            PmsMessageId = payload.MessageId,
            Operation = GetOperation(json, SyncEntityType.Patient),
            Name = $"{payload.FName} {payload.LName}".Trim(),
            FirstName = payload.FName,
            LastName = payload.LName,
            MiddleInitial = payload.MiddleI,
            PreferredName = payload.Preferred,
            DateOfBirth = payload.Birthdate != default ? payload.Birthdate : null,
            Gender = MapGender(payload.Gender),
            PhoneNumber = payload.HmPhone ?? payload.WirelessPhone ?? payload.WkPhone,
            Email = payload.Email,
            Address = payload.Address,
            Address2 = payload.Address2,
            City = payload.City,
            State = payload.State,
            ZipCode = payload.Zip,
            SSN = payload.SSN,
            // Map other fields...
        };
    }

    private RawDataDto ExtractAppointment(string json)
    {
        var payload = JsonSerializer.Deserialize<OpenDentalAppointmentPayload>(json);
        
        return new RawAppointmentData
        {
            PmsEntityId = payload.AptNum.ToString(),
            PmsMessageId = payload.MessageId,
            Operation = GetOperation(json, SyncEntityType.Appointment),
            PatientPmsId = payload.PatNum.ToString(),
            Date = payload.AptDateTime != default ? payload.AptDateTime : null,
            Duration = CalculateDuration(payload),
            Status = MapAppointmentStatus(payload.AptStatus),
            AppointmentType = payload.AppointmentTypeNum.ToString(),
            ProviderId = payload.ProvNum.ToString(),
            HygienistId = payload.ProvHyg.ToString(),
            Notes = payload.Note,
            IsNewPatient = payload.IsNewPatient == 1,
            IsHygiene = payload.IsHygiene == 1,
            DateTimeArrived = payload.DateTimeArrived != default ? payload.DateTimeArrived : null,
            DateTimeSeated = payload.DateTimeSeated != default ? payload.DateTimeSeated : null,
            DateTimeDismissed = payload.DateTimeDismissed != default ? payload.DateTimeDismissed : null,
            // Map other fields...
        };
    }

    private RawDataDto ExtractTreatmentPlan(string json)
    {
        var payload = JsonSerializer.Deserialize<OpenDentalTreatmentPlanPayload>(json);
        
        return new RawTreatmentPlanData
        {
            PmsEntityId = payload.TreatPlanNum.ToString(),
            PmsMessageId = payload.MessageId,
            Operation = GetOperation(json, SyncEntityType.TreatmentPlan),
            PatientPmsId = payload.PatNum.ToString(),
            Date = payload.DateTP != default ? payload.DateTP : null,
            Status = MapTreatmentPlanStatus(payload.TPStatus),
            Heading = payload.Heading,
            Note = payload.Note,
            // Map other fields...
        };
    }

    private string? MapGender(int gender)
    {
        return gender switch
        {
            0 => "Unknown",
            1 => "Male",
            2 => "Female",
            _ => null
        };
    }

    private string? MapAppointmentStatus(int status)
    {
        return status switch
        {
            0 => "Scheduled",
            1 => "Arrived",
            2 => "Seated",
            3 => "Procedures",
            4 => "CheckedOut",
            5 => "Broken",
            6 => "Complete",
            _ => "Unknown"
        };
    }

    private string? MapTreatmentPlanStatus(int status)
    {
        return status switch
        {
            0 => "Active",
            1 => "Accepted",
            2 => "Rejected",
            _ => "Unknown"
        };
    }

    private int? CalculateDuration(OpenDentalAppointmentPayload payload)
    {
        // Calculate duration based on appointment type or default
        // This is PMS-specific logic
        return 30; // Default 30 minutes
    }

    private bool ValidatePatientPayload(JsonDocument doc)
    {
        return doc.RootElement.TryGetProperty("PatNum", out _);
    }

    private bool ValidateAppointmentPayload(JsonDocument doc)
    {
        return doc.RootElement.TryGetProperty("AptNum", out _) &&
               doc.RootElement.TryGetProperty("PatNum", out _);
    }

    private bool ValidateTreatmentPlanPayload(JsonDocument doc)
    {
        return doc.RootElement.TryGetProperty("TreatPlanNum", out _) &&
               doc.RootElement.TryGetProperty("PatNum", out _);
    }
}

// DTOs matching OpenDental schema
public class OpenDentalPatientPayload
{
    public long PatNum { get; set; }
    public string? FName { get; set; }
    public string? LName { get; set; }
    public string? MiddleI { get; set; }
    public string? Preferred { get; set; }
    public DateTime Birthdate { get; set; }
    public int Gender { get; set; }
    public string? HmPhone { get; set; }
    public string? WkPhone { get; set; }
    public string? WirelessPhone { get; set; }
    public string? Email { get; set; }
    public string? Address { get; set; }
    public string? Address2 { get; set; }
    public string? City { get; set; }
    public string? State { get; set; }
    public string? Zip { get; set; }
    public string? SSN { get; set; }
    public string? MessageId { get; set; }
    // Add other fields as needed
}

public class OpenDentalAppointmentPayload
{
    public long AptNum { get; set; }
    public long PatNum { get; set; }
    public int AptStatus { get; set; }
    public DateTime AptDateTime { get; set; }
    public long ProvNum { get; set; }
    public long ProvHyg { get; set; }
    public long AppointmentTypeNum { get; set; }
    public string? Note { get; set; }
    public int IsNewPatient { get; set; }
    public int IsHygiene { get; set; }
    public DateTime DateTimeArrived { get; set; }
    public DateTime DateTimeSeated { get; set; }
    public DateTime DateTimeDismissed { get; set; }
    public string? MessageId { get; set; }
    // Add other fields as needed
}

public class OpenDentalTreatmentPlanPayload
{
    public long TreatPlanNum { get; set; }
    public long PatNum { get; set; }
    public DateTime DateTP { get; set; }
    public int TPStatus { get; set; }
    public string? Heading { get; set; }
    public string? Note { get; set; }
    public string? MessageId { get; set; }
    // Add other fields as needed
}
```

### **PmsAdapterFactory.cs**

```csharp
using System;
using System.Collections.Generic;
using Dental.PmsSync.Domain.Enums;

namespace Dental.PmsSync.Application.Adapters;

public interface IPmsAdapterFactory
{
    IPmsAdapter GetAdapter(PmsType pmsType);
}

public class PmsAdapterFactory : IPmsAdapterFactory
{
    private readonly Dictionary<PmsType, IPmsAdapter> _adapters;

    public PmsAdapterFactory(IEnumerable<IPmsAdapter> adapters)
    {
        _adapters = new Dictionary<PmsType, IPmsAdapter>();
        foreach (var adapter in adapters)
        {
            _adapters[adapter.PmsType] = adapter;
        }
    }

    public IPmsAdapter GetAdapter(PmsType pmsType)
    {
        if (!_adapters.TryGetValue(pmsType, out var adapter))
        {
            throw new NotSupportedException($"PMS type {pmsType} is not supported");
        }
        
        return adapter;
    }
}
```

---

## ELT Services

### **ExtractService.cs**

```csharp
using System.Threading.Tasks;
using Dental.PmsSync.Application.DTOs;
using Dental.PmsSync.Application.Adapters;
using Dental.PmsSync.Domain.Enums;

namespace Dental.PmsSync.Application.Services;

public interface IExtractService
{
    Task<RawDataDto> ExtractAsync(string rawJsonPayload, PmsType pmsType, SyncEntityType entityType);
}

public class ExtractService : IExtractService
{
    private readonly IPmsAdapterFactory _adapterFactory;

    public ExtractService(IPmsAdapterFactory adapterFactory)
    {
        _adapterFactory = adapterFactory;
    }

    public async Task<RawDataDto> ExtractAsync(string rawJsonPayload, PmsType pmsType, SyncEntityType entityType)
    {
        var adapter = _adapterFactory.GetAdapter(pmsType);
        
        // Validate payload
        var isValid = await adapter.ValidatePayloadAsync(rawJsonPayload, entityType);
        if (!isValid)
        {
            throw new InvalidPayloadException($"Invalid payload schema for {pmsType} - {entityType}");
        }
        
        // Extract to structured data
        var rawData = await adapter.ExtractAsync(rawJsonPayload, entityType);
        
        return rawData;
    }
}
```

### **LoadService.cs**

```csharp
using System;
using System.Threading.Tasks;
using Dental.PmsSync.Application.DTOs;
using Dental.PmsSync.Domain.Entities;
using Dental.PmsSync.Domain.Enums;

namespace Dental.PmsSync.Application.Services;

public interface ILoadService
{
    Task<PmsRawData> LoadAsync(
        Guid tenantId,
        Guid pmsConnectionId,
        PmsType pmsType,
        SyncEntityType entityType,
        string rawJsonPayload,
        RawDataDto extractedData,
        string correlationId);
}

public class LoadService : ILoadService
{
    private readonly IPmsRawDataRepository _rawDataRepository;
    private readonly ILogger<LoadService> _logger;

    public LoadService(
        IPmsRawDataRepository rawDataRepository,
        ILogger<LoadService> logger)
    {
        _rawDataRepository = rawDataRepository;
        _logger = logger;
    }

    public async Task<PmsRawData> LoadAsync(
        Guid tenantId,
        Guid pmsConnectionId,
        PmsType pmsType,
        SyncEntityType entityType,
        string rawJsonPayload,
        RawDataDto extractedData,
        string correlationId)
    {
        // Idempotency check by message ID
        if (!string.IsNullOrEmpty(extractedData.PmsMessageId))
        {
            var existingByMessageId = await _rawDataRepository.FindByMessageIdAsync(
                pmsConnectionId,
                extractedData.PmsMessageId);
            
            if (existingByMessageId != null)
            {
                _logger.LogInformation(
                    "Message {MessageId} already processed. Returning existing record.",
                    extractedData.PmsMessageId);
                return existingByMessageId;
            }
        }
        
        // Idempotency check by entity ID + operation
        var existingByEntity = await _rawDataRepository.FindByEntityIdAsync(
            pmsConnectionId,
            entityType,
            extractedData.PmsEntityId,
            extractedData.Operation);
        
        if (existingByEntity != null)
        {
            if (existingByEntity.Status == SyncStatus.Completed)
            {
                throw new DuplicateSyncException(
                    $"Entity {extractedData.PmsEntityId} with operation {extractedData.Operation} already synced");
            }
            
            // Update existing pending/failed record
            existingByEntity.UpdateExtractedData(JsonSerializer.Serialize(extractedData));
            existingByEntity.MarkAsProcessing();
            await _rawDataRepository.UpdateAsync(existingByEntity);
            return existingByEntity;
        }
        
        // Create new raw data record
        var rawData = new PmsRawData(
            tenantId: tenantId,
            pmsConnectionId: pmsConnectionId,
            pmsType: pmsType,
            entityType: entityType,
            operation: extractedData.Operation,
            rawJsonPayload: rawJsonPayload,
            extractedDataJson: JsonSerializer.Serialize(extractedData),
            pmsEntityId: extractedData.PmsEntityId,
            pmsMessageId: extractedData.PmsMessageId,
            correlationId: correlationId);
        
        rawData.MarkAsProcessing();
        await _rawDataRepository.InsertAsync(rawData);
        
        return rawData;
    }
}
```

### **TransformService.cs**

```csharp
using System;
using System.Text.Json;
using System.Threading.Tasks;
using Dental.PmsSync.Application.DTOs;
using Dental.PmsSync.Domain.Entities;
using Dental.PmsSync.Domain.Enums;
using Volo.Abp.MultiTenancy;

namespace Dental.PmsSync.Application.Services;

public interface ITransformService
{
    Task<TransformResult> TransformAsync(PmsRawData rawData, RawDataDto extractedData);
}

public class TransformService : ITransformService
{
    private readonly IPmsEntityMappingRepository _mappingRepository;
    private readonly ICurrentTenant _currentTenant;
    private readonly IPatientRepository _patientRepository;
    private readonly IAppointmentRepository _appointmentRepository;
    private readonly ITreatmentPlanRepository _treatmentPlanRepository;

    public TransformService(
        IPmsEntityMappingRepository mappingRepository,
        ICurrentTenant currentTenant,
        IPatientRepository patientRepository,
        IAppointmentRepository appointmentRepository,
        ITreatmentPlanRepository treatmentPlanRepository)
    {
        _mappingRepository = mappingRepository;
        _currentTenant = currentTenant;
        _patientRepository = patientRepository;
        _appointmentRepository = appointmentRepository;
        _treatmentPlanRepository = treatmentPlanRepository;
    }

    public async Task<TransformResult> TransformAsync(PmsRawData rawData, RawDataDto extractedData)
    {
        // Set tenant context
        using (_currentTenant.Change(rawData.TenantId))
        {
            return rawData.EntityType switch
            {
                SyncEntityType.Patient => await TransformPatientAsync(rawData, extractedData),
                SyncEntityType.Appointment => await TransformAppointmentAsync(rawData, extractedData),
                SyncEntityType.TreatmentPlan => await TransformTreatmentPlanAsync(rawData, extractedData),
                _ => throw new NotSupportedException($"Entity type {rawData.EntityType} not supported")
            };
        }
    }

    private async Task<TransformResult> TransformPatientAsync(
        PmsRawData rawData,
        RawDataDto extractedData)
    {
        var patientData = JsonSerializer.Deserialize<RawPatientData>(rawData.ExtractedDataJson);
        
        // Find or create entity mapping
        var mapping = await _mappingRepository.FindByPmsEntityIdAsync(
            rawData.PmsConnectionId,
            SyncEntityType.Patient,
            patientData.PmsEntityId);
        
        Patient patient;
        
        if (mapping != null)
        {
            // Update existing
            patient = await _patientRepository.GetAsync(mapping.TenantEntityId);
            
            var domainPatientData = MapToDomainPatientData(patientData);
            patient.Modify(domainPatientData);
            patient.LatestPmsSync = DateTime.UtcNow;
            
            await _patientRepository.UpdateAsync(patient);
        }
        else
        {
            // Create new
            var domainPatientData = MapToDomainPatientData(patientData);
            patient = new Patient(domainPatientData, patientData.PmsEntityId, rawData.TenantId);
            patient.LatestPmsSync = DateTime.UtcNow;
            
            await _patientRepository.InsertAsync(patient);
            
            // Create mapping
            mapping = new PmsEntityMapping(
                pmsConnectionId: rawData.PmsConnectionId,
                entityType: SyncEntityType.Patient,
                pmsEntityId: patientData.PmsEntityId,
                tenantEntityId: patient.Id);
            
            await _mappingRepository.InsertAsync(mapping);
        }
        
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

    // Similar methods for Appointment and TreatmentPlan...
}
```

---

## Service Bus Consumer

### **ServiceBusConsumerWorker.cs**

```csharp
using System;
using System.Text;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using Azure.Messaging.ServiceBus;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Volo.Abp.BackgroundWorkers;
using Volo.Abp.Threading;

namespace Dental.PmsSync.Application.BackgroundWorkers;

public class ServiceBusConsumerWorker : AsyncPeriodicBackgroundWorkerBase
{
    private readonly ServiceBusClient _serviceBusClient;
    private ServiceBusProcessor? _processor;

    public ServiceBusConsumerWorker(
        AbpAsyncTimer timer,
        IServiceScopeFactory serviceScopeFactory,
        ServiceBusClient serviceBusClient)
        : base(timer, serviceScopeFactory)
    {
        _serviceBusClient = serviceBusClient;
        Timer.Period = 60000; // 1 minute (not used, but required)
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
        var syncService = scope.ServiceProvider.GetRequiredService<IPmsSyncService>();
        var logger = scope.ServiceProvider.GetRequiredService<ILogger<ServiceBusConsumerWorker>>();

        try
        {
            var messageBody = args.Message.Body.ToString();
            var message = JsonSerializer.Deserialize<WebhookMessageDto>(messageBody);

            logger.LogInformation(
                "Processing webhook message. CorrelationId: {CorrelationId}, EntityType: {EntityType}",
                message.CorrelationId,
                message.EntityType);

            var result = await syncService.ProcessWebhookAsync(message);

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

            // Abandon message for retry, or dead-letter if max retries reached
            await args.AbandonMessageAsync(args.Message);
        }
    }

    private Task ProcessErrorAsync(ProcessErrorEventArgs args)
    {
        var logger = ServiceProvider.GetRequiredService<ILogger<ServiceBusConsumerWorker>>();
        logger.LogError(args.Exception,
            "Service Bus error. ErrorSource: {ErrorSource}, EntityPath: {EntityPath}",
            args.ErrorSource,
            args.EntityPath);

        return Task.CompletedTask;
    }

    public override async Task StopAsync(CancellationToken cancellationToken)
    {
        if (_processor != null)
        {
            await _processor.StopProcessingAsync(cancellationToken);
            await _processor.DisposeAsync();
        }

        await base.StopAsync(cancellationToken);
    }
}
```

---

## Configuration

### **Module Configuration**

```csharp
using Microsoft.Extensions.DependencyInjection;
using Volo.Abp.Modularity;
using Azure.Messaging.ServiceBus;

namespace Dental.PmsSync;

[DependsOn(
    typeof(AbpBackgroundWorkersModule),
    typeof(AbpMultiTenancyModule))]
public class PmsSyncModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        var configuration = context.Services.GetConfiguration();

        // Service Bus
        context.Services.AddSingleton(sp =>
        {
            var connectionString = configuration["Azure:ServiceBus:ConnectionString"];
            return new ServiceBusClient(connectionString);
        });

        // Register adapters
        context.Services.AddTransient<IPmsAdapter, OpenDentalAdapter>();
        // Add more adapters as needed

        context.Services.AddTransient<IPmsAdapterFactory, PmsAdapterFactory>();

        // Register services
        context.Services.AddTransient<IExtractService, ExtractService>();
        context.Services.AddTransient<ILoadService, LoadService>();
        context.Services.AddTransient<ITransformService, TransformService>();
        context.Services.AddTransient<IPmsSyncService, PmsSyncService>();

        // Register repositories
        context.Services.AddTransient<IPmsRawDataRepository, PmsRawDataRepository>();
        context.Services.AddTransient<IPmsConnectionRepository, PmsConnectionRepository>();
        context.Services.AddTransient<IPmsEntityMappingRepository, PmsEntityMappingRepository>();

        // Register background worker
        context.Services.AddSingleton<ServiceBusConsumerWorker>();
    }
}
```

### **appsettings.json**

```json
{
  "Azure": {
    "ServiceBus": {
      "ConnectionString": "Endpoint=sb://...",
      "TopicName": "pms-webhook-events",
      "SubscriptionName": "pms-sync-processor"
    },
    "KeyVault": {
      "VaultUri": "https://...vault.azure.net/"
    }
  },
  "PmsSync": {
    "MaxRetryCount": 5,
    "ProcessingTimeout": "00:05:00"
  }
}
```

---

## Enums

```csharp
namespace Dental.PmsSync.Domain.Enums;

public enum PmsType
{
    OpenDental = 1,
    Dentrix = 2,
    Eaglesoft = 3,
    // Add more as needed
}

public enum SyncEntityType
{
    Patient = 1,
    Appointment = 2,
    TreatmentPlan = 3
}

public enum SyncStatus
{
    Pending = 1,
    Processing = 2,
    Completed = 3,
    Failed = 4
}

public enum SyncOperation
{
    Create = 1,
    Update = 2,
    Delete = 3
}
```

---

## DTOs

```csharp
namespace Dental.PmsSync.Application.DTOs;

public class WebhookMessageDto
{
    public string Payload { get; set; }
    public string? WebhookUrl { get; set; }
    public string? CorrelationId { get; set; }
    public DateTime ReceivedAt { get; set; }
    public string? EntityType { get; set; }
}

public class RawDataDto
{
    public string PmsEntityId { get; set; }
    public string? PmsMessageId { get; set; }
    public SyncOperation Operation { get; set; }
}

public class RawPatientData : RawDataDto
{
    public string? Name { get; set; }
    public string? FirstName { get; set; }
    public string? LastName { get; set; }
    public DateTime? DateOfBirth { get; set; }
    public string? Gender { get; set; }
    public string? PhoneNumber { get; set; }
    public string? Email { get; set; }
    // ... other fields
}

public class RawAppointmentData : RawDataDto
{
    public string PatientPmsId { get; set; }
    public DateTime? Date { get; set; }
    public int? Duration { get; set; }
    public string? Status { get; set; }
    // ... other fields
}

public class RawTreatmentPlanData : RawDataDto
{
    public string PatientPmsId { get; set; }
    public DateTime? Date { get; set; }
    public string? Status { get; set; }
    // ... other fields
}

public class TransformResult
{
    public Guid EntityId { get; set; }
    public string EntityType { get; set; }
    public Guid MappingId { get; set; }
}

public class SyncResult
{
    public bool Success { get; set; }
    public string? ErrorMessage { get; set; }
    public string CorrelationId { get; set; }
}
```

