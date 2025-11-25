# Sync Strategy Recommendation: Centralized vs Per-Tenant

## ❓ Câu Hỏi

> **Nên sync về cho từng tenant hay sync về 1 database chung rồi transform sang các tenant?**

---

## 📊 So Sánh 2 Options

### **Option 1: Centralized Landing Zone + Per-Tenant Transform** ✅ **RECOMMENDED**

```
┌─────────────────────────────────────────────────────────┐
│  Master Database (Shared)                                │
│  ┌───────────────────────────────────────────────────┐  │
│  │  Landing Zone                                     │  │
│  │  - PmsRawData (raw JSON)                         │  │
│  │  - PmsSyncLog                                     │  │
│  │  - PmsConnection (tenant ↔ PMS mapping)          │  │
│  │  - PmsEntityMapping                              │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                    │
                    │ Transform & Route by TenantId
                    │
    ┌───────────────┼───────────────┐
    │               │               │
    ▼               ▼               ▼
┌─────────┐   ┌─────────┐   ┌─────────┐
│Tenant 1│   │Tenant 2│   │Tenant 3│
│   DB   │   │   DB   │   │   DB   │
└─────────┘   └─────────┘   └─────────┘
```

**Ưu điểm:**
- ✅ **Centralized Monitoring**: Tất cả raw data ở 1 chỗ, dễ debug và audit
- ✅ **Replay Capability**: Có thể replay transformation nếu có bug
- ✅ **Cross-Tenant Analytics**: Dễ implement analytics across tenants (nếu cần)
- ✅ **Cost Effective**: Shared infrastructure cho landing zone
- ✅ **Idempotency**: Dễ implement idempotency check ở centralized location
- ✅ **Data Lineage**: Dễ track data flow từ raw → transformed
- ✅ **ELT Best Practice**: Phù hợp với ELT approach (Extract-Load-Transform)

**Nhược điểm:**
- ⚠️ Cần routing logic để transform vào đúng tenant DB
- ⚠️ Master DB có thể trở thành bottleneck (cần optimize với indexing)
- ⚠️ Cần manage tenant context switching

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
- ✅ **Data Isolation**: Hoàn toàn isolated per tenant
- ✅ **Simpler Routing**: Không cần routing logic
- ✅ **Independent Scaling**: Có thể scale từng tenant DB độc lập
- ✅ **Tenant Context**: Dễ manage tenant context (không cần switch)

**Nhược điểm:**
- ❌ **Harder Debugging**: Phải check nhiều DBs khi debug
- ❌ **No Replay**: Khó replay transformation nếu có bug
- ❌ **Duplicate Infrastructure**: Duplicate tables cho mỗi tenant
- ❌ **Cross-Tenant Analytics**: Khó implement analytics across tenants
- ❌ **Not ELT Best Practice**: Không phù hợp với ELT approach

---

## 💡 **Recommendation: Option 1 (Centralized Landing Zone)**

### **Lý Do Chính:**

#### **1. ELT Approach**
ELT (Extract-Load-Transform) approach yêu cầu:
- **Extract**: Parse data từ PMS
- **Load**: Lưu raw data vào **Landing Zone** (centralized)
- **Transform**: Transform raw data → domain entities (per-tenant)

Landing zone nên centralized để:
- Dễ manage và monitor
- Có thể replay transformation
- Support multiple transformation pipelines

#### **2. Debugging & Troubleshooting**
Khi có issue:
- ✅ Tất cả raw data ở 1 chỗ → dễ tìm và debug
- ✅ Có thể xem lại raw payload để understand issue
- ✅ Dễ audit trail

Với per-tenant approach:
- ❌ Phải check nhiều DBs
- ❌ Khó track data flow

#### **3. Replay Capability**
Nếu có bug trong transformation logic:
- ✅ Có thể re-run transformation từ raw data
- ✅ Không cần request lại từ PMS

Với per-tenant:
- ❌ Phải có backup của raw data
- ❌ Hoặc phải request lại từ PMS

#### **4. Cost Efficiency**
- ✅ Shared infrastructure cho landing zone
- ✅ Không duplicate tables cho mỗi tenant
- ✅ Dễ optimize storage (compression, archiving)

#### **5. Future-Proof**
- ✅ Dễ implement cross-tenant analytics (nếu cần)
- ✅ Dễ implement data warehouse / data lake
- ✅ Dễ implement compliance & audit requirements

---

## 🏗️ Implementation Details

### **Database Structure**

#### **Master Database (Shared)**
```sql
-- Landing Zone
CREATE TABLE PmsRawData (
    Id UNIQUEIDENTIFIER PRIMARY KEY,
    TenantId UNIQUEIDENTIFIER NOT NULL,
    PmsConnectionId UNIQUEIDENTIFIER NOT NULL,
    PmsType INT NOT NULL,
    EntityType INT NOT NULL,
    Operation INT NOT NULL,
    RawJsonPayload NVARCHAR(MAX) NOT NULL,
    ExtractedDataJson NVARCHAR(MAX),
    PmsEntityId NVARCHAR(255) NOT NULL,
    PmsMessageId NVARCHAR(255),
    Status INT NOT NULL,
    CorrelationId NVARCHAR(255) NOT NULL,
    ReceivedAt DATETIME2 NOT NULL,
    ProcessedAt DATETIME2,
    TransformedEntityId UNIQUEIDENTIFIER,
    TransformedEntityType NVARCHAR(255),
    -- Indexes
    INDEX IX_PmsRawData_TenantId (TenantId),
    INDEX IX_PmsRawData_PmsConnectionId (PmsConnectionId),
    INDEX IX_PmsRawData_Status (Status),
    INDEX IX_PmsRawData_PmsEntityId (PmsConnectionId, EntityType, PmsEntityId),
    INDEX IX_PmsRawData_MessageId (PmsConnectionId, PmsMessageId)
);

-- Connection Management
CREATE TABLE PmsConnection (
    Id UNIQUEIDENTIFIER PRIMARY KEY,
    TenantId UNIQUEIDENTIFIER NOT NULL,
    PmsType INT NOT NULL,
    ConnectionName NVARCHAR(255) NOT NULL,
    WebhookUrl NVARCHAR(500) NOT NULL,
    WebhookSecret NVARCHAR(500) NOT NULL,
    IsActive BIT NOT NULL,
    Settings NVARCHAR(MAX), -- JSON
    -- Indexes
    INDEX IX_PmsConnection_TenantId (TenantId),
    INDEX IX_PmsConnection_WebhookUrl (WebhookUrl)
);

-- Entity Mapping (PMS ID → Tenant Entity ID)
CREATE TABLE PmsEntityMapping (
    Id UNIQUEIDENTIFIER PRIMARY KEY,
    PmsConnectionId UNIQUEIDENTIFIER NOT NULL,
    EntityType INT NOT NULL,
    PmsEntityId NVARCHAR(255) NOT NULL,
    TenantEntityId UNIQUEIDENTIFIER NOT NULL,
    LastSyncedAt DATETIME2 NOT NULL,
    LastSyncHash NVARCHAR(255),
    -- Unique constraint
    UNIQUE (PmsConnectionId, EntityType, PmsEntityId),
    INDEX IX_PmsEntityMapping_TenantEntity (TenantEntityId)
);

-- Sync Log (Audit Trail)
CREATE TABLE PmsSyncLog (
    Id UNIQUEIDENTIFIER PRIMARY KEY,
    TenantId UNIQUEIDENTIFIER NOT NULL,
    PmsConnectionId UNIQUEIDENTIFIER NOT NULL,
    PmsRawDataId UNIQUEIDENTIFIER,
    EntityType INT NOT NULL,
    Operation INT NOT NULL,
    Status INT NOT NULL,
    ErrorMessage NVARCHAR(MAX),
    ProcessingDuration BIGINT, -- milliseconds
    CorrelationId NVARCHAR(255) NOT NULL,
    Metadata NVARCHAR(MAX), -- JSON
    CreatedAt DATETIME2 NOT NULL
);
```

#### **Tenant Databases**
```sql
-- Domain entities (existing)
-- Patient, Appointment, TreatmentPlan tables
-- No landing zone tables needed
```

---

### **Code Implementation**

#### **1. Tenant Context Switching**

```csharp
public class TransformService : ITransformService
{
    private readonly ICurrentTenant _currentTenant;
    
    public async Task<TransformResult> TransformAsync(
        PmsRawData rawData,
        RawDataDto extractedData)
    {
        // Switch to tenant context
        using (_currentTenant.Change(rawData.TenantId))
        {
            // All repository calls will use tenant DB
            return await TransformToDomainEntity(rawData, extractedData);
        }
    }
}
```

#### **2. Routing Logic**

```csharp
public class PmsSyncService : IPmsSyncService
{
    public async Task<SyncResult> ProcessWebhookAsync(WebhookMessageDto message)
    {
        // 1. Get connection (contains TenantId)
        var connection = await _connectionRepository.GetByWebhookUrlAsync(message.WebhookUrl);
        
        // 2. Extract
        var extractedData = await _extractService.ExtractAsync(...);
        
        // 3. Load to Master DB (Landing Zone)
        var rawData = await _loadService.LoadAsync(
            tenantId: connection.TenantId,  // Store tenant ID
            pmsConnectionId: connection.Id,
            ...
        );
        
        // 4. Transform (automatically routes to tenant DB via tenant context)
        var result = await _transformService.TransformAsync(rawData, extractedData);
        
        return result;
    }
}
```

---

## 📈 Performance Considerations

### **Potential Bottlenecks & Solutions**

#### **1. Master DB Bottleneck**
**Problem**: Master DB có thể trở thành bottleneck khi có nhiều tenants

**Solutions**:
- ✅ **Indexing**: Proper indexes trên TenantId, Status, PmsConnectionId
- ✅ **Partitioning**: Partition PmsRawData table by TenantId hoặc date
- ✅ **Archiving**: Archive old raw data (sau khi transform xong)
- ✅ **Read Replicas**: Use read replicas cho reporting/analytics

#### **2. Tenant DB Write Performance**
**Problem**: Transform writes vào tenant DB có thể chậm

**Solutions**:
- ✅ **Batch Processing**: Batch multiple transforms
- ✅ **Async Processing**: Process transforms asynchronously
- ✅ **Connection Pooling**: Optimize connection pooling

#### **3. Service Bus Throughput**
**Problem**: Service Bus có thể không handle được high volume

**Solutions**:
- ✅ **Partitioned Topics**: Use partitioned topics
- ✅ **Multiple Subscriptions**: Scale out consumers
- ✅ **Premium Tier**: Use Premium tier nếu cần > 1000 msg/sec

---

## 🔒 Security & Compliance

### **Data Isolation**
- ✅ Tenant data được isolate ở tenant DBs
- ✅ Raw data có TenantId để ensure isolation
- ✅ Use ABP's multi-tenant context để enforce isolation

### **Access Control**
- ✅ Only sync service có thể write vào tenant DBs
- ✅ Role-based access cho viewing raw data
- ✅ Audit logging cho all operations

### **Data Retention**
- ✅ Raw data có thể archive sau khi transform
- ✅ Compliance với data retention policies
- ✅ Easy to delete tenant data (GDPR compliance)

---

## 📊 Monitoring & Observability

### **Metrics to Track**

#### **Master DB (Landing Zone)**
- Raw data ingestion rate
- Processing queue depth
- Failed syncs count
- Average processing time

#### **Per Tenant**
- Sync success rate
- Entity sync counts (Patient, Appointment, TreatmentPlan)
- Last sync timestamp
- Error rate

### **Dashboards**
- **Centralized Dashboard**: Overview của tất cả tenants
- **Per-Tenant Dashboard**: Chi tiết cho từng tenant
- **Alerting**: Alert khi có issues

---

## 🎯 Kết Luận

### **Recommendation: Centralized Landing Zone (Option 1)**

**Lý do chính:**
1. ✅ **ELT Best Practice**: Phù hợp với ELT approach
2. ✅ **Debugging**: Dễ debug và troubleshoot
3. ✅ **Replay**: Có thể replay transformation
4. ✅ **Cost**: Shared infrastructure, cost-effective
5. ✅ **Future-Proof**: Dễ extend cho analytics, compliance

**Implementation:**
- Landing Zone ở **Master DB** (shared)
- Transform & route vào **Tenant DBs** (per-tenant)
- Use **ABP's multi-tenant context** để switch tenant context
- Proper **indexing** và **archiving** strategy

**Trade-offs:**
- Cần routing logic (nhưng đơn giản với ABP's tenant context)
- Master DB có thể bottleneck (nhưng có thể optimize)

**Kết luận:** Option 1 là lựa chọn tốt nhất cho use case này.

