# Kiến Trúc Sync Module - PMS Data Integration

## 📋 Tổng Quan

Module sync data từ nhiều PMS (Practice Management System) khác nhau vào hệ thống multi-tenant sử dụng **ELT (Extract-Load-Transform)** approach với **Adapter Pattern** để support multiple PMS providers.

---

## 🎯 Mục Tiêu

1. **Multi-PMS Support**: Hỗ trợ nhiều PMS khác nhau (OpenDental, Dentrix, Eaglesoft, v.v.)
2. **Multi-Tenant**: Mỗi tenant có thể connect với nhiều PMS khác nhau
3. **ELT Approach**: Extract → Load raw data → Transform sang domain model
4. **Idempotency**: Đảm bảo không duplicate data khi retry
5. **Scalability**: Có thể scale để handle high volume
6. **Reliability**: Xử lý được downtime, errors, retries

---

## 🏗️ Kiến Trúc Tổng Thể

```
┌─────────────────────────────────────────────────────────────────┐
│                    PMS Systems (External)                       │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │  OpenDental  │  │   Dentrix    │  │  Eaglesoft   │  ...    │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘         │
│         │                 │                  │                  │
│         └─────────────────┼──────────────────┘                  │
│                           │ Webhook (HTTP POST)                 │
└───────────────────────────┼─────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│              Azure Function (Webhook Receiver)                   │
│  - Validate HMAC/Signature                                       │
│  - Extract Tenant ID from webhook                               │
│  - Encrypt PII/PHI data (HIPAA compliance)                       │
│  - Enrich message (PmsConnectionId, TenantId, PmsType, etc.)   │
│  - Push encrypted message to Service Bus                        │
└───────────────────────────┬─────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│              Azure Service Bus (Topic + Subscription)           │
│  Topic: pms-webhook-events                                      │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │ Subscription: pms-sync-processor                         │   │
│  │ - Durable                                                │   │
│  │ - MaxDeliveryCount: 5                                    │   │
│  │ - DeadLetterQueue: Enabled                               │   │
│  └──────────────────────────────────────────────────────────┘   │
└───────────────────────────┬─────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│         ABP Application - PMS Sync Module                       │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  ServiceBus Consumer (Background Worker)                  │  │
│  │  - Read messages from Service Bus                         │  │
│  │  - Route to appropriate handler                           │  │
│  └───────────────────┬──────────────────────────────────────┘  │
│                      │                                          │
│                      ▼                                          │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  PMS Adapter Factory                                     │  │
│  │  - Identify PMS type from message                        │  │
│  │  - Get appropriate adapter                               │  │
│  └───────────────────┬──────────────────────────────────────┘  │
│                      │                                          │
│                      ▼                                          │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  PMS Adapters (Adapter Pattern)                         │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │  │
│  │  │OpenDental    │  │  Dentrix     │  │  Eaglesoft   │  │  │
│  │  │  Adapter     │  │  Adapter     │  │  Adapter     │  │  │
│  │  └──────────────┘  └──────────────┘  └──────────────┘  │  │
│  │  - Extract: Parse PMS-specific JSON to RawData         │  │
│  └───────────────────┬──────────────────────────────────────┘  │
│                      │                                          │
│                      ▼                                          │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  ELT Pipeline                                            │  │
│  │                                                          │  │
│  │  ┌────────────────────────────────────────────────────┐  │  │
│  │  │  EXTRACT Layer                                    │  │  │
│  │  │  - Parse webhook payload                          │  │  │
│  │  │  - Validate schema                                │  │  │
│  │  │  - Extract to RawData entities                    │  │  │
│  │  └───────────────────┬────────────────────────────────┘  │  │
│  │                      │                                    │  │
│  │                      ▼                                    │  │
│  │  ┌────────────────────────────────────────────────────┐  │  │
│  │  │  LOAD Layer (Landing Zone)                        │  │  │
│  │  │  - Save raw JSON to Landing Zone                  │  │  │
│  │  │  - Save RawData entities to database              │  │  │
│  │  │  - Idempotency check                              │  │  │
│  │  └───────────────────┬────────────────────────────────┘  │  │
│  │                      │                                    │  │
│  │                      ▼                                    │  │
│  │  ┌────────────────────────────────────────────────────┐  │  │
│  │  │  TRANSFORM Layer                                  │  │  │
│  │  │  - Map RawData → Domain Entities                  │  │  │
│  │  │  - Business rule validation                       │  │  │
│  │  │  - Data enrichment                                │  │  │
│  │  └───────────────────┬────────────────────────────────┘  │  │
│  │                      │                                    │  │
│  │                      ▼                                    │  │
│  │  ┌────────────────────────────────────────────────────┐  │  │
│  │  │  MediatR CQRS Layer                                │  │  │
│  │  │  - ProcessWebhookCommand                          │  │  │
│  │  │  - ExtractDataCommand / LoadDataCommand          │  │  │
│  │  │  - TransformDataCommand                           │  │  │
│  │  │  - SyncPatientCommand / SyncAppointmentCommand   │  │  │
│  │  │  - Publish domain events via MediatR             │  │  │
│  │  └───────────────────┬────────────────────────────────┘  │  │
│  └──────────────────────┼────────────────────────────────────┘  │
│                         │                                        │
│                         ▼                                        │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Domain Layer (DDD)                                      │  │
│  │  - Patient, Appointment, TreatmentPlan                  │  │
│  │  - Business Logic                                       │  │
│  └───────────────────┬──────────────────────────────────────┘  │
│                      │                                          │
│                      ▼                                          │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Persistence Layer                                       │  │
│  │  - Tenant-specific database                             │  │
│  │  - EF Core repositories                                 │  │
│  └──────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🗄️ Database Architecture

### **Option 1: Centralized Landing Zone + Per-Tenant Transform (RECOMMENDED)**

```
┌─────────────────────────────────────────────────────────────┐
│  Master Database (Shared)                                    │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Landing Zone Tables                                 │   │
│  │  - PmsRawData (raw JSON)                            │   │
│  │  - PmsSyncLog                                       │   │
│  │  - PmsConnection (tenant ↔ PMS mapping)            │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ Transform & Route
                            │
        ┌───────────────────┼───────────────────┐
        │                   │                   │
        ▼                   ▼                   ▼
┌──────────────┐   ┌──────────────┐   ┌──────────────┐
│ Tenant 1 DB  │   │ Tenant 2 DB  │   │ Tenant 3 DB  │
│              │   │              │   │              │
│ - Patient    │   │ - Patient    │   │ - Patient    │
│ - Appointment│   │ - Appointment│   │ - Appointment│
│ - Treatment  │   │ - Treatment  │   │ - Treatment  │
│   Plan       │   │   Plan       │   │   Plan       │
└──────────────┘   └──────────────┘   └──────────────┘
```

**Ưu điểm:**
- ✅ Centralized monitoring & debugging
- ✅ Dễ audit trail
- ✅ Có thể replay transformation
- ✅ Shared resources cho landing zone
- ✅ Dễ implement cross-tenant analytics (nếu cần)

**Nhược điểm:**
- ⚠️ Cần routing logic để transform vào đúng tenant DB
- ⚠️ Master DB có thể trở thành bottleneck (cần optimize)

---

### **Option 2: Per-Tenant Landing Zone**

```
┌──────────────┐   ┌──────────────┐   ┌──────────────┐
│ Tenant 1 DB  │   │ Tenant 2 DB  │   │ Tenant 3 DB  │
│              │   │              │   │              │
│ Landing Zone │   │ Landing Zone │   │ Landing Zone │
│ - PmsRawData │   │ - PmsRawData │   │ - PmsRawData │
│              │   │              │   │              │
│ Domain       │   │ Domain       │   │ Domain       │
│ - Patient    │   │ - Patient    │   │ - Patient    │
│ - Appointment│   │ - Appointment│   │ - Appointment│
│ - Treatment  │   │ - Treatment  │   │ - Treatment  │
│   Plan       │   │   Plan       │   │   Plan       │
└──────────────┘   └──────────────┘   └──────────────┘
```

**Ưu điểm:**
- ✅ Data isolation hoàn toàn
- ✅ Dễ scale per tenant
- ✅ Không cần routing logic

**Nhược điểm:**
- ❌ Khó cross-tenant monitoring
- ❌ Duplicate infrastructure
- ❌ Khó audit trail tổng thể

---

## 💡 **Recommendation: Option 1 (Centralized Landing Zone)**

**Lý do:**
1. **ELT Approach**: Landing zone nên centralized để dễ manage và transform
2. **Debugging**: Dễ debug khi có issue (tất cả raw data ở 1 chỗ)
3. **Replay**: Có thể replay transformation nếu có bug
4. **Analytics**: Dễ implement cross-tenant analytics (nếu cần)
5. **Cost**: Shared infrastructure cho landing zone

**Implementation:**
- Landing Zone ở Master DB (shared)
- Transform & route vào Tenant DBs
- Use correlation ID để track qua các layers

---

## 📦 Module Structure

```
Dental.PmsSync/
├── Domain/
│   ├── Entities/
│   │   ├── PmsConnection.cs              // Tenant ↔ PMS mapping
│   │   ├── PmsRawData.cs                // Landing zone entity
│   │   ├── PmsSyncLog.cs                // Sync audit log
│   │   └── PmsSyncStatus.cs             // Sync status tracking
│   │
│   ├── ValueObjects/
│   │   ├── RawPatientData.cs            // Raw patient data from PMS
│   │   ├── RawAppointmentData.cs        // Raw appointment data
│   │   ├── RawTreatmentPlanData.cs     // Raw treatment plan data
│   │   └── PmsWebhookPayload.cs         // Webhook payload wrapper
│   │
│   ├── Enums/
│   │   ├── PmsType.cs                   // OpenDental, Dentrix, etc.
│   │   ├── SyncEntityType.cs            // Patient, Appointment, TreatmentPlan
│   │   ├── SyncStatus.cs                // Pending, Processing, Completed, Failed
│   │   └── SyncOperation.cs              // Create, Update, Delete
│   │
│   └── Services/
│       └── IPmsAdapter.cs                // Adapter interface
│
├── Application/
│   ├── Adapters/
│   │   ├── IPmsAdapter.cs               // Base adapter interface
│   │   ├── OpenDentalAdapter.cs          // OpenDental implementation
│   │   ├── DentrixAdapter.cs            // Dentrix implementation (future)
│   │   └── EaglesoftAdapter.cs          // Eaglesoft implementation (future)
│   │
│   ├── Commands/
│   │   ├── ProcessWebhook/
│   │   │   ├── ProcessWebhookCommand.cs
│   │   │   └── ProcessWebhookCommandHandler.cs
│   │   ├── ExtractData/
│   │   │   ├── ExtractDataCommand.cs
│   │   │   └── ExtractDataCommandHandler.cs
│   │   ├── LoadData/
│   │   │   ├── LoadDataCommand.cs
│   │   │   └── LoadDataCommandHandler.cs
│   │   ├── TransformData/
│   │   │   ├── TransformDataCommand.cs
│   │   │   └── TransformDataCommandHandler.cs
│   │   ├── SyncPatient/
│   │   │   ├── SyncPatientCommand.cs
│   │   │   └── SyncPatientCommandHandler.cs
│   │   ├── SyncAppointment/
│   │   │   ├── SyncAppointmentCommand.cs
│   │   │   └── SyncAppointmentCommandHandler.cs
│   │   └── SyncTreatmentPlan/
│   │       ├── SyncTreatmentPlanCommand.cs
│   │       └── SyncTreatmentPlanCommandHandler.cs
│   │
│   ├── Queries/
│   │   ├── GetPmsConnection/
│   │   │   ├── GetPmsConnectionQuery.cs
│   │   │   └── GetPmsConnectionQueryHandler.cs
│   │   ├── GetPmsRawData/
│   │   │   ├── GetPmsRawDataQuery.cs
│   │   │   └── GetPmsRawDataQueryHandler.cs
│   │   └── GetPmsEntityMapping/
│   │       ├── GetPmsEntityMappingQuery.cs
│   │       └── GetPmsEntityMappingQueryHandler.cs
│   │
│   ├── DTOs/
│   │   ├── WebhookMessageDto.cs
│   │   ├── RawDataDto.cs
│   │   ├── SyncResultDto.cs
│   │   └── TransformResultDto.cs
│   │
│   └── BackgroundWorkers/
│       └── ServiceBusConsumerWorker.cs   // Service Bus consumer
│
├── Infrastructure/
│   ├── Repositories/
│   │   ├── IPmsRawDataRepository.cs
│   │   ├── PmsRawDataRepository.cs
│   │   ├── IPmsConnectionRepository.cs
│   │   └── PmsConnectionRepository.cs
│   │
│   └── Persistence/
│       ├── PmsSyncDbContext.cs          // Master DB context
│       └── Configurations/
│           ├── PmsRawDataConfiguration.cs
│           └── PmsConnectionConfiguration.cs
│
└── HttpApi/
    └── Controllers/
        └── PmsWebhookController.cs      // Webhook endpoint (optional, nếu không dùng Azure Function)
```

---

## 🗃️ Core Entities

### **1. PmsConnection** (Master DB)

```csharp
public class PmsConnection : FullAuditedAggregateRoot<Guid>
{
    public Guid TenantId { get; private set; }
    public PmsType PmsType { get; private set; }  // OpenDental, Dentrix, etc.
    public string ConnectionName { get; private set; }
    public string WebhookUrl { get; private set; }
    public string WebhookSecret { get; private set; }  // For HMAC validation
    public bool IsActive { get; private set; }
    public Dictionary<string, string> Settings { get; private set; }  // PMS-specific settings
    
    // Mapping: PMS Entity ID → Tenant Entity ID
    public ICollection<PmsEntityMapping> EntityMappings { get; private set; }
}
```

### **2. PmsRawData** (Master DB - Landing Zone)

```csharp
public class PmsRawData : FullAuditedAggregateRoot<Guid>
{
    public Guid TenantId { get; private set; }
    public Guid PmsConnectionId { get; private set; }
    public PmsConnection PmsConnection { get; private set; }
    
    public PmsType PmsType { get; private set; }
    public SyncEntityType EntityType { get; private set; }  // Patient, Appointment, TreatmentPlan
    public SyncOperation Operation { get; private set; }   // Create, Update, Delete
    
    // Raw JSON payload from PMS
    public string RawJsonPayload { get; private set; }
    
    // Extracted structured data (from adapter)
    public string? ExtractedDataJson { get; private set; }
    
    // Idempotency
    public string PmsEntityId { get; private set; }  // ID từ PMS
    public string? PmsMessageId { get; private set; }  // Message ID từ webhook
    
    // Status tracking
    public SyncStatus Status { get; private set; }
    public DateTime? ProcessedAt { get; private set; }
    public string? ErrorMessage { get; private set; }
    public int RetryCount { get; private set; }
    
    // Correlation
    public string CorrelationId { get; private set; }
    public DateTime ReceivedAt { get; private set; }
    
    // Transformation result
    public Guid? TransformedEntityId { get; private set; }  // ID của entity sau transform
    public string? TransformedEntityType { get; private set; }
}
```

### **3. PmsSyncLog** (Master DB - Audit Trail)

```csharp
public class PmsSyncLog : FullAuditedAggregateRoot<Guid>
{
    public Guid TenantId { get; private set; }
    public Guid PmsConnectionId { get; private set; }
    public Guid? PmsRawDataId { get; private set; }
    
    public SyncEntityType EntityType { get; private set; }
    public SyncOperation Operation { get; private set; }
    public SyncStatus Status { get; private set; }
    
    public string? ErrorMessage { get; private set; }
    public string? StackTrace { get; private set; }
    
    public TimeSpan? ProcessingDuration { get; private set; }
    public string CorrelationId { get; private set; }
    
    public Dictionary<string, object> Metadata { get; private set; }
}
```

### **4. PmsEntityMapping** (Master DB - ID Mapping)

```csharp
public class PmsEntityMapping : FullAuditedAggregateRoot<Guid>
{
    public Guid PmsConnectionId { get; private set; }
    public PmsConnection PmsConnection { get; private set; }
    
    public SyncEntityType EntityType { get; private set; }
    public string PmsEntityId { get; private set; }  // ID từ PMS
    public Guid TenantEntityId { get; private set; }  // ID trong tenant DB
    
    public DateTime LastSyncedAt { get; private set; }
    public string? LastSyncHash { get; private set; }  // Hash để detect changes
}
```

---

## 🔌 Adapter Pattern Implementation

### **1. Base Adapter Interface**

```csharp
public interface IPmsAdapter
{
    PmsType PmsType { get; }
    
    // Extract: Parse PMS-specific JSON to RawData
    Task<RawDataDto> ExtractAsync(string rawJsonPayload, SyncEntityType entityType);
    
    // Validate: Validate PMS-specific schema
    Task<bool> ValidatePayloadAsync(string rawJsonPayload, SyncEntityType entityType);
    
    // Get Entity ID from payload
    string GetEntityId(string rawJsonPayload, SyncEntityType entityType);
    
    // Get Operation (Create, Update, Delete) from payload
    SyncOperation GetOperation(string rawJsonPayload, SyncEntityType entityType);
}
```

### **2. OpenDental Adapter**

```csharp
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
    
    private RawDataDto ExtractPatient(string json)
    {
        var payload = JsonSerializer.Deserialize<OpenDentalPatientPayload>(json);
        
        return new RawPatientData
        {
            PmsEntityId = payload.PatNum.ToString(),
            Name = $"{payload.FName} {payload.LName}",
            DateOfBirth = payload.Birthdate,
            Gender = MapGender(payload.Gender),
            PhoneNumber = payload.HmPhone ?? payload.WirelessPhone,
            Email = payload.Email,
            Address = payload.Address,
            City = payload.City,
            State = payload.State,
            ZipCode = payload.Zip,
            // ... map other fields
        };
    }
    
    private RawDataDto ExtractAppointment(string json)
    {
        var payload = JsonSerializer.Deserialize<OpenDentalAppointmentPayload>(json);
        
        return new RawAppointmentData
        {
            PmsEntityId = payload.AptNum.ToString(),
            PatientPmsId = payload.PatNum.ToString(),
            Date = payload.AptDateTime,
            Duration = CalculateDuration(payload),
            Status = MapAppointmentStatus(payload.AptStatus),
            // ... map other fields
        };
    }
    
    private RawDataDto ExtractTreatmentPlan(string json)
    {
        var payload = JsonSerializer.Deserialize<OpenDentalTreatmentPlanPayload>(json);
        
        return new RawTreatmentPlanData
        {
            PmsEntityId = payload.TreatPlanNum.ToString(),
            PatientPmsId = payload.PatNum.ToString(),
            Date = payload.DateTP,
            Status = MapTreatmentPlanStatus(payload.TPStatus),
            // ... map other fields
        };
    }
    
    // Helper methods for mapping...
}
```

---

## 🔄 ELT Pipeline Implementation

### **1. Extract Layer**

```csharp
public class ExtractService : IExtractService
{
    private readonly IPmsAdapterFactory _adapterFactory;
    
    public async Task<RawDataDto> ExtractAsync(
        string rawJsonPayload,
        PmsType pmsType,
        SyncEntityType entityType)
    {
        var adapter = _adapterFactory.GetAdapter(pmsType);
        
        // Validate payload
        var isValid = await adapter.ValidatePayloadAsync(rawJsonPayload, entityType);
        if (!isValid)
        {
            throw new InvalidPayloadException("Invalid payload schema");
        }
        
        // Extract to structured data
        var rawData = await adapter.ExtractAsync(rawJsonPayload, entityType);
        
        return rawData;
    }
}
```

### **2. Load Layer (Landing Zone)**

```csharp
public class LoadService : ILoadService
{
    private readonly IPmsRawDataRepository _rawDataRepository;
    private readonly IPmsEntityMappingRepository _mappingRepository;
    
    public async Task<PmsRawData> LoadAsync(
        Guid tenantId,
        Guid pmsConnectionId,
        PmsType pmsType,
        SyncEntityType entityType,
        string rawJsonPayload,
        RawDataDto extractedData,
        string correlationId)
    {
        // Idempotency check
        var existing = await _rawDataRepository.FindByMessageIdAsync(
            pmsConnectionId,
            extractedData.PmsMessageId);
        
        if (existing != null)
        {
            return existing;  // Already processed
        }
        
        // Check by entity ID + operation
        var existingByEntity = await _rawDataRepository.FindByEntityIdAsync(
            pmsConnectionId,
            entityType,
            extractedData.PmsEntityId,
            extractedData.Operation);
        
        if (existingByEntity != null && existingByEntity.Status == SyncStatus.Completed)
        {
            throw new DuplicateSyncException("Entity already synced");
        }
        
        // Create raw data record
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
        
        await _rawDataRepository.InsertAsync(rawData);
        
        return rawData;
    }
}
```

### **3. Transform Layer**

```csharp
public class TransformService : ITransformService
{
    private readonly IPmsEntityMappingRepository _mappingRepository;
    private readonly ICurrentTenant _currentTenant;
    
    public async Task<TransformResult> TransformAsync(
        PmsRawData rawData,
        RawDataDto extractedData)
    {
        // Set tenant context
        using (_currentTenant.Change(rawData.TenantId))
        {
            return rawData.EntityType switch
            {
                SyncEntityType.Patient => await TransformPatientAsync(rawData, extractedData),
                SyncEntityType.Appointment => await TransformAppointmentAsync(rawData, extractedData),
                SyncEntityType.TreatmentPlan => await TransformTreatmentPlanAsync(rawData, extractedData),
                _ => throw new NotSupportedException()
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
        }
        else
        {
            // Create new
            var domainPatientData = MapToDomainPatientData(patientData);
            patient = new Patient(domainPatientData, patientData.PmsEntityId, rawData.TenantId);
            
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
            name: raw.Name,
            dateOfBirth: raw.DateOfBirth,
            phoneNumber: raw.PhoneNumber,
            // ... map other fields
        );
    }
}
```

---

## 🔧 Service Bus Consumer

```csharp
public class ServiceBusConsumerWorker : BackgroundService
{
    private readonly ServiceBusClient _serviceBusClient;
    private readonly ServiceBusProcessor _processor;
    private readonly IServiceProvider _serviceProvider;
    
    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _processor.ProcessMessageAsync += ProcessMessageAsync;
        _processor.ProcessErrorAsync += ProcessErrorAsync;
        
        await _processor.StartProcessingAsync(stoppingToken);
    }
    
    private async Task ProcessMessageAsync(ProcessMessageEventArgs args)
    {
        using var scope = _serviceProvider.CreateScope();
        var mediator = scope.ServiceProvider.GetRequiredService<IMediator>();
        
        try
        {
            var message = JsonSerializer.Deserialize<WebhookMessageDto>(args.Message.Body.ToString());
            
            var command = new ProcessWebhookCommand
            {
                Payload = message.Payload,
                WebhookUrl = message.WebhookUrl,
                CorrelationId = message.CorrelationId,
                ReceivedAt = message.ReceivedAt
            };
            
            await mediator.Send(command);
            
            await args.CompleteMessageAsync(args.Message);
        }
        catch (Exception ex)
        {
            // Log error
            // Message will be retried or moved to DLQ
            await args.AbandonMessageAsync(args.Message);
        }
    }
}
```

---

## 📊 MediatR Command Orchestration

### **ProcessWebhookCommand (Orchestrator)**

```csharp
public class ProcessWebhookCommand : IRequest<SyncResult>
{
    public string Payload { get; set; }
    public string? WebhookUrl { get; set; }
    public string? CorrelationId { get; set; }
    public DateTime ReceivedAt { get; set; }
}

public class ProcessWebhookCommandHandler : IRequestHandler<ProcessWebhookCommand, SyncResult>
{
    private readonly IMediator _mediator;
    private readonly IPmsConnectionRepository _connectionRepository;
    
    public async Task<SyncResult> Handle(ProcessWebhookCommand request, CancellationToken cancellationToken)
    {
        var correlationId = request.CorrelationId ?? Guid.NewGuid().ToString();
        var startTime = DateTime.UtcNow;
        
        try
        {
            // 1. Get PMS connection (Query)
            var connectionQuery = new GetPmsConnectionByWebhookUrlQuery 
            { 
                WebhookUrl = request.WebhookUrl 
            };
            var connection = await _mediator.Send(connectionQuery, cancellationToken);
            
            if (connection == null || !connection.IsActive)
            {
                throw new PmsConnectionNotFoundException();
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
            await _rawDataRepository.UpdateAsync(rawData);
            
            return new SyncResult 
            { 
                Success = true, 
                CorrelationId = correlationId 
            };
        }
        catch (Exception ex)
        {
            // Log error via MediatR notification or logging behavior
            throw;
        }
    }
}
```

---

## 🛠️ Technology Stack

### **Core**
- **.NET 8** / **ABP Framework** (Multi-tenant support)
- **Entity Framework Core** (ORM)
- **Azure Service Bus** (Message queue)
- **Azure Functions** (Webhook receiver - optional)

### **Storage**
- **SQL Server** / **PostgreSQL** (Master DB + Tenant DBs)
- **Azure Blob Storage** (Optional: Store large raw JSON files)

### **Monitoring & Observability**
- **Application Insights** / **Serilog** (Logging)
- **Azure Monitor** (Metrics & Alerts)

### **Security**
- **Azure Key Vault** (Store secrets, webhook keys)
- **HMAC** (Webhook signature validation)

---

## 🔐 Security Considerations

1. **Webhook Validation**
   - HMAC signature validation ở Azure Function
   - Store webhook secrets trong Key Vault

2. **Tenant Isolation**
   - Validate tenant ID từ webhook
   - Use ABP's multi-tenant context switching

3. **Data Encryption (HIPAA Compliance)**
   - **Azure Function**: Encrypt PII/PHI data trước khi push vào Service Bus
     - Field-level encryption cho sensitive fields (name, SSN, DOB, address, phone, email)
     - Use Azure Key Vault cho encryption keys
     - Support key rotation và versioning
   - **Service Bus**: Encryption at rest (automatic)
   - **App**: Decrypt PII/PHI data sau khi đọc từ Service Bus
     - Use Azure Key Vault cho decryption keys
     - Validate decrypted data
   - **Domain Layer**: Encrypt sensitive fields trong domain entities
     - Use ABP's encryption attributes
     - Store encrypted data trong database

4. **Access Control**
   - Role-based access cho sync operations
   - Audit logging cho all sync activities

---

## 📈 Scalability & Performance

### **Horizontal Scaling**
- Service Bus Consumer: Scale out multiple instances
- Use Service Bus Sessions nếu cần ordering per tenant

### **Performance Optimization**
- Batch processing cho high volume
- Async/await throughout
- Database indexing trên:
  - `PmsRawData`: (PmsConnectionId, EntityType, PmsEntityId, Status)
  - `PmsEntityMapping`: (PmsConnectionId, EntityType, PmsEntityId)

### **Caching**
- Cache PMS connections (Redis)
- Cache entity mappings (Redis)

---

## 🧪 Testing Strategy

1. **Unit Tests**
   - Adapter extraction logic
   - Transform mapping logic
   - Business rule validation

2. **Integration Tests**
   - End-to-end ELT pipeline
   - Idempotency scenarios
   - Error handling

3. **Load Tests**
   - High volume webhook processing
   - Service Bus throughput

---

## 📝 Implementation Checklist

### **Phase 1: Foundation**
- [ ] Create PmsSync module structure
- [ ] Define core entities (PmsConnection, PmsRawData, etc.)
- [ ] Setup Master DB context
- [ ] Implement base adapter interface

### **Phase 2: OpenDental Adapter**
- [ ] Implement OpenDentalAdapter
- [ ] Create OpenDental DTOs (matching SQL schema)
- [ ] Implement extraction logic
- [ ] Unit tests

### **Phase 3: ELT Pipeline với MediatR CQRS (với HIPAA Decryption)**
- [ ] Implement ExtractDataCommand & Handler
- [ ] Implement LoadDataCommand & Handler (Landing Zone)
- [ ] Implement TransformDataCommand & Handler
- [ ] Implement ProcessWebhookCommand & Handler (orchestrator)
  - [ ] PII/PHI data decryption (HIPAA compliance)
  - [ ] Azure Key Vault integration for decryption
- [ ] Implement SyncPatientCommand & Handler
- [ ] Implement SyncAppointmentCommand & Handler
- [ ] Implement SyncTreatmentPlanCommand & Handler
- [ ] Implement Pipeline Behaviors (Validation, Logging, Transaction)

### **Phase 4: Service Bus Integration**
- [ ] Setup Azure Service Bus
- [ ] Implement ServiceBusConsumerWorker
- [ ] Error handling & retry logic

### **Phase 5: Webhook Receiver (với HIPAA Encryption)**
- [ ] Azure Function for webhook
- [ ] HMAC validation
- [ ] PII/PHI data encryption (HIPAA compliance)
  - [ ] Identify sensitive fields
  - [ ] Azure Key Vault integration
  - [ ] Field-level encryption implementation
  - [ ] Key rotation support
- [ ] Message enrichment (PmsConnectionId, TenantId, PmsType)
- [ ] Push encrypted message to Service Bus

### **Phase 6: Monitoring & Observability**
- [ ] Logging implementation
- [ ] Metrics & alerts
- [ ] Dashboard

---

## 🎯 Kết Luận

Kiến trúc này cung cấp:

1. ✅ **Flexible**: Dễ thêm PMS mới (chỉ cần implement adapter)
2. ✅ **Scalable**: Có thể scale horizontally
3. ✅ **Reliable**: Idempotency, retry, DLQ
4. ✅ **Maintainable**: Clear separation of concerns
5. ✅ **Multi-tenant**: Support multiple tenants với data isolation
6. ✅ **ELT Approach**: Raw data được lưu trước, transform sau

**Recommendation**: Sử dụng **Centralized Landing Zone** (Option 1) để dễ manage và debug.

