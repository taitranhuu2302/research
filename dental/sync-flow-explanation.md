# Giải Thích Flow: PMS Sync với Azure Function & Service Bus

## ✅ Flow Đúng Của Bạn

```
1. Azure Function tạo webhook URL
   ↓
2. Đăng ký webhook URL vào PMS
   ↓
3. PMS có thay đổi → POST webhook → Azure Function
   ↓
4. Azure Function validate & tạo message → Azure Service Bus
   ↓
5. App Background Worker listen Service Bus
   ↓
6. Thực hiện ELT (Extract-Load-Transform)
```

**Đúng rồi!** 🎯

---

## ❓ Vấn Đề: Azure Function Làm Sao Biết Webhook Thuộc Connection Nào?

### **Scenario:**

Bạn có **nhiều tenants**, mỗi tenant có **nhiều PMS connections**:

```
Tenant 1:
  - Connection 1: OpenDental → Webhook URL: https://func.azure.com/webhook/tenant1-opendental-abc123
  - Connection 2: Dentrix → Webhook URL: https://func.azure.com/webhook/tenant1-dentrix-xyz789

Tenant 2:
  - Connection 3: OpenDental → Webhook URL: https://func.azure.com/webhook/tenant2-opendental-def456
```

### **Khi PMS gửi webhook:**

```
PMS gửi POST đến: https://func.azure.com/webhook/tenant1-opendental-abc123
```

**Azure Function cần biết:**
- ✅ Webhook này thuộc **Connection nào**?
- ✅ Connection này thuộc **Tenant nào**?
- ✅ PMS type là gì? (OpenDental, Dentrix, ...)
- ✅ Settings gì? (HMAC secret, mapping rules, ...)

---

## 🔍 Cách 1: Lookup bằng Webhook URL (Current)

### **Flow:**

```
1. PMS POST → Azure Function
   URL: https://func.azure.com/webhook/tenant1-opendental-abc123
   Body: { "PatNum": 123, "FName": "John", ... }

2. Azure Function:
   - Extract webhook URL từ HTTP request
   - Query DB: SELECT * FROM PmsConnection WHERE WebhookUrl = '...'
   - Get: TenantId, PmsConnectionId, PmsType, WebhookSecret
   - Validate HMAC
   - Create message → Service Bus
     {
       "Payload": "{...}",
       "WebhookUrl": "https://func.azure.com/webhook/tenant1-opendental-abc123"  ← Cần để lookup
     }

3. App Background Worker:
   - Read message từ Service Bus
   - Extract WebhookUrl từ message
   - Query DB: SELECT * FROM PmsConnection WHERE WebhookUrl = '...'  ← Lại lookup lần nữa!
   - Get: TenantId, PmsConnectionId, PmsType
   - Process ELT
```

**Vấn đề:**
- ❌ **App phải lookup database lần nữa** (duplicate lookup)
- ❌ **Tăng database load** không cần thiết
- ❌ **Tăng latency** (thêm 1 DB query)

---

## ✅ Cách 2: Enrich Message tại Azure Function (Optimized)

### **Flow:**

```
1. PMS POST → Azure Function
   URL: https://func.azure.com/webhook/tenant1-opendental-abc123
   Body: { "PatNum": 123, "FName": "John", ... }

2. Azure Function:
   - Extract webhook URL từ HTTP request
   - Query DB: SELECT * FROM PmsConnection WHERE WebhookUrl = '...'  ← Chỉ lookup 1 lần
   - Get: TenantId, PmsConnectionId, PmsType, WebhookSecret
   - Validate HMAC
   - Create message → Service Bus với metadata:
     {
       "Body": "{...}",  // Raw payload
       "ApplicationProperties": {
         "PmsConnectionId": "guid-connection-1",
         "TenantId": "guid-tenant-1",
         "PmsType": "1",  // OpenDental
         "WebhookUrl": "https://..."  // Optional: for audit
       }
     }

3. App Background Worker:
   - Read message từ Service Bus
   - Extract metadata từ ApplicationProperties  ← Không cần lookup DB!
     - PmsConnectionId = "guid-connection-1"
     - TenantId = "guid-tenant-1"
     - PmsType = "1"
   - Process ELT (đã có đủ thông tin)
```

**Lợi ích:**
- ✅ **App không cần lookup database** (metadata đã có sẵn)
- ✅ **Giảm database load** (chỉ 1 lookup ở Azure Function)
- ✅ **Giảm latency** (bỏ DB query trong app)
- ✅ **Better performance**
- ✅ **HIPAA Compliance**: PII/PHI data được encrypt trước khi vào Service Bus

---

## 🎯 Tại Sao Cần WebhookUrl?

### **Trong Cách 1 (Current):**

WebhookUrl cần thiết vì:
- App cần lookup `PmsConnection` từ database
- WebhookUrl là **unique identifier** để tìm connection

### **Trong Cách 2 (Optimized):**

WebhookUrl **KHÔNG CẦN** trong message body vì:
- Azure Function đã lookup và enrich metadata
- App đã có `PmsConnectionId` → không cần lookup nữa
- WebhookUrl chỉ cần trong ApplicationProperties (optional, cho audit)

---

## 📊 So Sánh Chi Tiết

### **Cách 1: Lookup ở App**

```
┌─────────────────────────────────────────────────────────┐
│ Azure Function                                           │
│ 1. Receive webhook: /webhook/tenant1-opendental-abc123 │
│ 2. Query DB: GetPmsConnectionByWebhookUrl()            │ ← DB Lookup #1
│ 3. Validate HMAC                                        │
│ 4. Push to Service Bus:                                │
│    {                                                     │
│      "Payload": "...",                                   │
│      "WebhookUrl": "https://..."                        │
│    }                                                     │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ App Background Worker                                    │
│ 1. Read message từ Service Bus                          │
│ 2. Extract WebhookUrl                                   │
│ 3. Query DB: GetPmsConnectionByWebhookUrl()            │ ← DB Lookup #2 (DUPLICATE!)
│ 4. Get TenantId, PmsConnectionId, PmsType              │
│ 5. Process ELT                                          │
└─────────────────────────────────────────────────────────┘

Total DB Lookups: 2 (1 ở Function + 1 ở App)
```

### **Cách 2: Enrich tại Function (với HIPAA Encryption)**

```
┌─────────────────────────────────────────────────────────┐
│ Azure Function                                           │
│ 1. Receive webhook: /webhook/tenant1-opendental-abc123 │
│ 2. Query DB: GetPmsConnectionByWebhookUrl()            │ ← DB Lookup #1
│ 3. Validate HMAC                                        │
│ 4. Extract PII/PHI data từ payload                     │
│ 5. Encrypt PII/PHI data (HIPAA compliance)              │ ← Encryption
│    - Use Azure Key Vault for encryption keys            │
│    - Encrypt sensitive fields (name, SSN, DOB, etc.)    │
│ 6. Enrich message với metadata:                        │
│    - PmsConnectionId                                    │
│    - TenantId                                           │
│    - PmsType                                            │
│ 7. Push encrypted payload to Service Bus                │
│    - Encrypted payload in message body                   │
│    - Metadata in ApplicationProperties                  │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ App Background Worker                                    │
│ 1. Read message từ Service Bus                          │
│ 2. Extract metadata từ ApplicationProperties          │ ← No DB Lookup!
│    - PmsConnectionId (đã có)                            │
│    - TenantId (đã có)                                   │
│    - PmsType (đã có)                                    │
│ 3. Decrypt PII/PHI data (HIPAA compliance)             │ ← Decryption
│    - Use Azure Key Vault for decryption keys             │
│    - Decrypt sensitive fields                            │
│ 4. Optional: Validate metadata (security check)         │
│ 5. Process ELT với decrypted data                       │
└─────────────────────────────────────────────────────────┘

Total DB Lookups: 1 (chỉ ở Function)
HIPAA Compliance: ✅ Encrypted in transit và at rest
```

---

## 💡 Recommendation

**Sử dụng Cách 2: Enrich tại Azure Function**

**Lý do:**
1. ✅ **Giảm database load** (1 lookup thay vì 2)
2. ✅ **Tăng performance** (app không cần query DB)
3. ✅ **Better scalability** (ít dependency vào DB)
4. ✅ **Cleaner architecture** (metadata trong message)

---

## 🔧 Implementation

### **Azure Function Flow (với HIPAA Encryption):**

```
1. Receive webhook request
2. Lookup PmsConnection (by webhook URL hoặc connectionId)
3. Validate HMAC signature
4. Read payload từ request body
5. Extract PII/PHI data từ payload
6. Encrypt PII/PHI data:
   - Identify sensitive fields (name, SSN, DOB, address, phone, email, etc.)
   - Get encryption key từ Azure Key Vault
   - Encrypt sensitive fields (field-level encryption)
   - Hoặc encrypt toàn bộ payload (payload-level encryption)
7. Enrich message với metadata:
   - PmsConnectionId
   - TenantId
   - PmsType
   - Encryption metadata (algorithm, key version, etc.)
8. Push encrypted message to Service Bus:
   - Encrypted payload trong message body
   - Metadata trong ApplicationProperties
   - Encryption info trong ApplicationProperties (nếu cần)
```

### **App Background Worker Flow (với HIPAA Decryption):**

```
1. Read message từ Service Bus
2. Extract metadata từ ApplicationProperties:
   - PmsConnectionId
   - TenantId
   - PmsType
   - Encryption metadata (nếu có)
3. Decrypt PII/PHI data:
   - Get decryption key từ Azure Key Vault (same key version)
   - Decrypt sensitive fields (field-level)
   - Hoặc decrypt toàn bộ payload (payload-level)
4. Validate decrypted data
5. Process ELT với decrypted data
6. Store encrypted data vào database (domain layer tự encrypt lại nếu cần)
```

---

## 🔐 HIPAA Compliance - Encryption Strategy

### **Các Trường Dữ Liệu Cần Encrypt (PII/PHI):**

**Patient Data:**
- Name (First, Last, Middle)
- Date of Birth
- Social Security Number (SSN)
- Address (Street, City, State, Zip)
- Phone Numbers
- Email Address
- Insurance Information
- Medical Record Numbers

**Appointment Data:**
- Patient Name (reference)
- Appointment Notes
- Diagnosis Information

**Treatment Plan Data:**
- Treatment Details
- Financial Information
- Notes

### **Encryption Approach:**

**Option 1: Field-Level Encryption (Recommended)**
- Encrypt từng sensitive field riêng biệt
- Non-sensitive fields (IDs, timestamps) không encrypt
- Flexible: có thể query non-sensitive fields
- Performance: chỉ encrypt/decrypt cần thiết

**Option 2: Payload-Level Encryption**
- Encrypt toàn bộ payload
- Simpler implementation
- Performance: encrypt/decrypt toàn bộ payload
- Không thể query fields

### **Encryption Keys Management:**

- ✅ **Azure Key Vault**: Store encryption keys
- ✅ **Key Rotation**: Support key versioning
- ✅ **Access Control**: Managed Identity cho Function & App
- ✅ **Audit Logging**: Track key access

### **Encryption Flow:**

```
Azure Function:
  1. Receive payload từ PMS
  2. Identify PII/PHI fields
  3. Get encryption key từ Key Vault
  4. Encrypt sensitive fields
  5. Push encrypted message to Service Bus

Service Bus:
  - Message body: Encrypted payload
  - ApplicationProperties: Metadata (non-sensitive)
  - Encryption at rest: Service Bus tự động encrypt

App:
  1. Read encrypted message từ Service Bus
  2. Get decryption key từ Key Vault (same version)
  3. Decrypt sensitive fields
  4. Process ELT với decrypted data
  5. Store vào database (domain layer encrypt lại nếu cần)
```

### **Security Considerations:**

- ✅ **Encryption in Transit**: HTTPS cho webhook, TLS cho Service Bus
- ✅ **Encryption at Rest**: Service Bus encrypt messages
- ✅ **Key Management**: Azure Key Vault với rotation
- ✅ **Access Control**: Managed Identity, RBAC
- ✅ **Audit Trail**: Log all encryption/decryption operations
- ✅ **Data Minimization**: Chỉ encrypt fields cần thiết

---

## 🎯 Kết Luận

**Câu trả lời cho câu hỏi của bạn:**

> "Tại sao cần WebhookUrl trong message?"

**Trong cách hiện tại (Cách 1):**
- ✅ Cần WebhookUrl để app lookup `PmsConnection` từ database

**Trong cách tối ưu (Cách 2):**
- ❌ **KHÔNG CẦN** WebhookUrl trong message body
- ✅ Azure Function đã enrich metadata (PmsConnectionId, TenantId, PmsType)
- ✅ App đọc metadata từ ApplicationProperties → không cần lookup DB
- ✅ **HIPAA Compliance**: Encrypt PII/PHI data trước khi vào Service Bus

**Flow đúng của bạn (với HIPAA):**
```
PMS → Azure Function (encrypt + enrich metadata) 
  → Service Bus (encrypted) 
  → App (decrypt + read metadata) 
  → ELT
```

✅ **Đúng rồi!** Với encryption để tuân thủ HIPAA.

