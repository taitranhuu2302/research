# Đánh Giá Bảng Log cho Monitoring Sync Process

## 📊 Bảng Log Hiện Tại

### **1. PmsRawData** (Landing Zone + Status Tracking)

```csharp
public class PmsRawData
{
    // Identity
    public Guid Id { get; }
    public Guid TenantId { get; }
    public Guid PmsConnectionId { get; }
    
    // Entity Info
    public PmsType PmsType { get; }
    public SyncEntityType EntityType { get; }
    public SyncOperation Operation { get; }
    
    // Data
    public string RawJsonPayload { get; }
    public string? ExtractedDataJson { get; }
    public string PmsEntityId { get; }
    public string? PmsMessageId { get; }
    
    // Status Tracking
    public SyncStatus Status { get; }
    public DateTime? ProcessedAt { get; }
    public string? ErrorMessage { get; }
    public int RetryCount { get; }
    
    // Correlation
    public string CorrelationId { get; }
    public DateTime ReceivedAt { get; }
    
    // Result
    public Guid? TransformedEntityId { get; }
    public string? TransformedEntityType { get; }
}
```

### **2. PmsSyncLog** (Audit Trail)

```csharp
public class PmsSyncLog
{
    public Guid Id { get; }
    public Guid TenantId { get; }
    public Guid PmsConnectionId { get; }
    public Guid? PmsRawDataId { get; }
    
    public SyncEntityType EntityType { get; }
    public SyncOperation Operation { get; }
    public SyncStatus Status { get; }
    
    public string? ErrorMessage { get; }
    public string? StackTrace { get; }
    
    public TimeSpan? ProcessingDuration { get; }
    public string CorrelationId { get; }
    
    public Dictionary<string, object> Metadata { get; }
}
```

---

## ✅ Điểm Mạnh

### **PmsRawData:**
- ✅ Track status qua các stages (Pending → Processing → Completed/Failed)
- ✅ CorrelationId để trace qua các layers
- ✅ RetryCount để track retry attempts
- ✅ ErrorMessage để debug
- ✅ Timestamps (ReceivedAt, ProcessedAt)
- ✅ Link đến transformed entity

### **PmsSyncLog:**
- ✅ ProcessingDuration để track performance
- ✅ ErrorMessage + StackTrace để debug
- ✅ Metadata dictionary cho flexible logging
- ✅ Link đến PmsRawData

---

## ⚠️ Thiếu Sót Cho Monitoring

### **1. Stage-Level Tracking**

**Vấn đề:** Không biết message đang ở stage nào (Extract, Load, Transform)

**Cần thêm:**
```csharp
public enum SyncStage
{
    Received = 1,        // Azure Function received
    Extracted = 2,       // Extract completed
    Loaded = 3,         // Load to landing zone completed
    Transformed = 4,     // Transform completed
    Completed = 5,      // Full sync completed
    Failed = 6
}

public class PmsRawData
{
    // ✅ Thêm
    public SyncStage? CurrentStage { get; private set; }
    public DateTime? StageStartedAt { get; private set; }
    public DateTime? StageCompletedAt { get; private set; }
    
    // ✅ Thêm timestamps cho từng stage
    public DateTime? ExtractedAt { get; private set; }
    public DateTime? LoadedAt { get; private set; }
    public DateTime? TransformedAt { get; private set; }
    
    // ✅ Thêm duration cho từng stage
    public TimeSpan? ExtractDuration { get; private set; }
    public TimeSpan? LoadDuration { get; private set; }
    public TimeSpan? TransformDuration { get; private set; }
}
```

### **2. Performance Metrics**

**Vấn đề:** Không có metrics chi tiết để analyze performance

**Cần thêm:**
```csharp
public class PmsSyncLog
{
    // ✅ Thêm stage-level durations
    public TimeSpan? ExtractDuration { get; private set; }
    public TimeSpan? LoadDuration { get; private set; }
    public TimeSpan? TransformDuration { get; private set; }
    
    // ✅ Thêm message size để track throughput
    public long? PayloadSizeBytes { get; private set; }
    
    // ✅ Thêm processing node/instance
    public string? ProcessingNode { get; private set; }  // Machine/instance name
}
```

### **3. Error Classification**

**Vấn đề:** Không phân loại errors để dễ analyze

**Cần thêm:**
```csharp
public enum SyncErrorType
{
    ValidationError = 1,      // Invalid payload
    ExtractionError = 2,     // Extract failed
    LoadError = 3,            // Load failed
    TransformError = 4,       // Transform failed
    BusinessRuleError = 5,    // Business validation failed
    DatabaseError = 6,        // DB operation failed
    NetworkError = 7,         // Network issue
    TimeoutError = 8,         // Processing timeout
    UnknownError = 9
}

public class PmsSyncLog
{
    // ✅ Thêm
    public SyncErrorType? ErrorType { get; private set; }
    public string? ErrorCode { get; private set; }  // Standardized error code
}
```

### **4. Retry Tracking**

**Vấn đề:** Không track retry history chi tiết

**Cần thêm:**
```csharp
public class PmsRawData
{
    // ✅ Thêm
    public DateTime? LastRetryAt { get; private set; }
    public string? LastRetryReason { get; private set; }
    public int MaxRetryCount { get; private set; } = 5;
}

// ✅ Hoặc tạo bảng riêng cho retry history
public class PmsSyncRetryLog
{
    public Guid Id { get; }
    public Guid PmsRawDataId { get; }
    public int RetryAttempt { get; }
    public DateTime RetriedAt { get; }
    public string? RetryReason { get; }
    public SyncStatus Status { get; }
    public string? ErrorMessage { get; }
}
```

### **5. Batch/Throughput Tracking**

**Vấn đề:** Không track throughput metrics

**Cần thêm:**
```csharp
public class PmsSyncMetrics
{
    public Guid Id { get; }
    public DateTime Timestamp { get; }
    public Guid? TenantId { get; }
    public Guid? PmsConnectionId { get; }
    
    // Throughput
    public int MessagesProcessed { get; }
    public int MessagesSucceeded { get; }
    public int MessagesFailed { get; }
    
    // Performance
    public TimeSpan AverageProcessingTime { get; }
    public TimeSpan P95ProcessingTime { get; }
    public TimeSpan P99ProcessingTime { get; }
    
    // Errors
    public int ErrorCount { get; }
    public Dictionary<SyncErrorType, int> ErrorCountByType { get; }
    
    // Per Entity Type
    public Dictionary<SyncEntityType, int> CountByEntityType { get; }
}
```

### **6. Service Bus Message Tracking**

**Vấn đề:** Không track Service Bus message details

**Cần thêm:**
```csharp
public class PmsRawData
{
    // ✅ Thêm
    public string? ServiceBusMessageId { get; private set; }
    public string? ServiceBusSequenceNumber { get; private set; }
    public DateTime? ServiceBusEnqueuedAt { get; private set; }
    public DateTime? ServiceBusDequeuedAt { get; private set; }
    public int? ServiceBusDeliveryCount { get; private set; }
}
```

### **7. HIPAA Compliance Tracking**

**Vấn đề:** Không track encryption/decryption operations

**Cần thêm:**
```csharp
public class PmsRawData
{
    // ✅ Thêm
    public bool IsEncrypted { get; private set; }
    public string? EncryptionKeyVersion { get; private set; }
    public DateTime? EncryptedAt { get; private set; }
    public DateTime? DecryptedAt { get; private set; }
    public TimeSpan? EncryptionDuration { get; private set; }
    public TimeSpan? DecryptionDuration { get; private set; }
}
```

---

## 📊 Đề Xuất Cải Thiện

### **Option 1: Enhance Existing Tables (Recommended)**

Thêm fields vào `PmsRawData` và `PmsSyncLog`:

```csharp
public class PmsRawData : FullAuditedAggregateRoot<Guid>
{
    // Existing fields...
    
    // ✅ Stage Tracking
    public SyncStage? CurrentStage { get; private set; }
    public DateTime? ExtractedAt { get; private set; }
    public DateTime? LoadedAt { get; private set; }
    public DateTime? TransformedAt { get; private set; }
    public TimeSpan? ExtractDuration { get; private set; }
    public TimeSpan? LoadDuration { get; private set; }
    public TimeSpan? TransformDuration { get; private set; }
    
    // ✅ Service Bus Tracking
    public string? ServiceBusMessageId { get; private set; }
    public DateTime? ServiceBusEnqueuedAt { get; private set; }
    public DateTime? ServiceBusDequeuedAt { get; private set; }
    
    // ✅ HIPAA Tracking
    public bool IsEncrypted { get; private set; }
    public string? EncryptionKeyVersion { get; private set; }
    
    // ✅ Retry Tracking
    public DateTime? LastRetryAt { get; private set; }
    public string? LastRetryReason { get; private set; }
    
    // ✅ Performance
    public long? PayloadSizeBytes { get; private set; }
}

public class PmsSyncLog : FullAuditedAggregateRoot<Guid>
{
    // Existing fields...
    
    // ✅ Error Classification
    public SyncErrorType? ErrorType { get; private set; }
    public string? ErrorCode { get; private set; }
    
    // ✅ Stage Durations
    public TimeSpan? ExtractDuration { get; private set; }
    public TimeSpan? LoadDuration { get; private set; }
    public TimeSpan? TransformDuration { get; private set; }
    
    // ✅ Performance
    public long? PayloadSizeBytes { get; private set; }
    public string? ProcessingNode { get; private set; }
}
```

### **Option 2: Separate Metrics Table**

Tạo bảng riêng cho aggregated metrics:

```sql
CREATE TABLE PmsSyncMetrics (
    Id UNIQUEIDENTIFIER PRIMARY KEY,
    Timestamp DATETIME2 NOT NULL,
    TenantId UNIQUEIDENTIFIER,
    PmsConnectionId UNIQUEIDENTIFIER,
    
    -- Throughput
    MessagesProcessed INT NOT NULL,
    MessagesSucceeded INT NOT NULL,
    MessagesFailed INT NOT NULL,
    
    -- Performance
    AverageProcessingTimeMs BIGINT,
    P95ProcessingTimeMs BIGINT,
    P99ProcessingTimeMs BIGINT,
    
    -- Errors
    ErrorCount INT NOT NULL,
    ErrorCountByType NVARCHAR(MAX), -- JSON
    
    -- Per Entity Type
    CountByEntityType NVARCHAR(MAX), -- JSON
    
    -- Indexes
    INDEX IX_PmsSyncMetrics_Timestamp (Timestamp),
    INDEX IX_PmsSyncMetrics_TenantId (TenantId),
    INDEX IX_PmsSyncMetrics_PmsConnectionId (PmsConnectionId)
);
```

---

## 📈 Metrics Cần Monitor

### **1. Throughput Metrics**
- Messages per second/minute/hour
- Success rate
- Failure rate
- Per tenant, per PMS, per entity type

### **2. Performance Metrics**
- Average processing time
- P50, P95, P99 processing time
- Stage-level durations (Extract, Load, Transform)
- Service Bus latency (enqueue → dequeue)

### **3. Error Metrics**
- Error rate
- Error by type
- Error by entity type
- Retry rate
- Dead letter queue count

### **4. Health Metrics**
- Active connections
- Queue depth
- Processing backlog
- Failed syncs requiring attention

---

## 🎯 Recommendation

### **High Priority (Cần thêm ngay):**

1. ✅ **Stage Tracking** (`CurrentStage`, stage timestamps)
2. ✅ **Stage Durations** (ExtractDuration, LoadDuration, TransformDuration)
3. ✅ **Error Classification** (ErrorType, ErrorCode)
4. ✅ **Service Bus Tracking** (MessageId, EnqueuedAt, DequeuedAt)

### **Medium Priority (Nên có):**

5. ✅ **Retry Tracking** (LastRetryAt, LastRetryReason)
6. ✅ **Performance Metrics** (PayloadSizeBytes, ProcessingNode)
7. ✅ **HIPAA Tracking** (IsEncrypted, EncryptionKeyVersion)

### **Low Priority (Nice to have):**

8. ✅ **Aggregated Metrics Table** (PmsSyncMetrics) - cho reporting
9. ✅ **Retry History Table** (PmsSyncRetryLog) - nếu cần chi tiết

---

## 📝 Updated PmsSyncLog Structure

```csharp
public class PmsSyncLog : FullAuditedAggregateRoot<Guid>
{
    // Identity
    public Guid TenantId { get; private set; }
    public Guid PmsConnectionId { get; private set; }
    public Guid? PmsRawDataId { get; private set; }
    
    // Entity Info
    public SyncEntityType EntityType { get; private set; }
    public SyncOperation Operation { get; private set; }
    public SyncStatus Status { get; private set; }
    public SyncStage? Stage { get; private set; }  // ✅ NEW
    
    // Error Info
    public SyncErrorType? ErrorType { get; private set; }  // ✅ NEW
    public string? ErrorCode { get; private set; }  // ✅ NEW
    public string? ErrorMessage { get; private set; }
    public string? StackTrace { get; private set; }
    
    // Performance
    public TimeSpan? ProcessingDuration { get; private set; }
    public TimeSpan? ExtractDuration { get; private set; }  // ✅ NEW
    public TimeSpan? LoadDuration { get; private set; }  // ✅ NEW
    public TimeSpan? TransformDuration { get; private set; }  // ✅ NEW
    public long? PayloadSizeBytes { get; private set; }  // ✅ NEW
    public string? ProcessingNode { get; private set; }  // ✅ NEW
    
    // Correlation
    public string CorrelationId { get; private set; }
    public DateTime CreatedAt { get; private set; }
    
    // Metadata
    public Dictionary<string, object> Metadata { get; private set; }
}
```

---

## ✅ Kết Luận

**Bảng log hiện tại:**
- ✅ **Đủ cơ bản** để track status và errors
- ⚠️ **Thiếu** stage-level tracking
- ⚠️ **Thiếu** performance metrics chi tiết
- ⚠️ **Thiếu** error classification
- ⚠️ **Thiếu** Service Bus tracking

**Recommendation:**
- ✅ Enhance `PmsRawData` và `PmsSyncLog` với các fields đề xuất
- ✅ Tạo `PmsSyncMetrics` table cho aggregated reporting (optional)
- ✅ Implement logging ở tất cả stages (Extract, Load, Transform)

