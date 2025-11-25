# PMS Sync Module - Documentation

## 📚 Tài Liệu Tổng Hợp

Tài liệu này tổng hợp toàn bộ kiến trúc, implementation và best practices cho PMS Sync Module.

---

## 🎯 Tổng Quan

Module sync data từ nhiều PMS (Practice Management System) khác nhau vào hệ thống multi-tenant sử dụng:
- **ELT Approach** (Extract-Load-Transform)
- **Adapter Pattern** (support multiple PMS providers)
- **MediatR CQRS** pattern
- **Azure Service Bus** (durable messaging)
- **HIPAA Compliance** (encryption)

**Flow:**
```
PMS → Azure Function (encrypt + enrich) → Service Bus → App (decrypt) → ELT
```

---

## 📖 Tài Liệu Chính

### **1. [sync-architecture.md](./sync-architecture.md)** ⭐ **BẮT ĐẦU TỪ ĐÂY**

Kiến trúc tổng thể của sync module:
- Architecture overview với diagrams
- Database architecture (Centralized Landing Zone)
- Module structure
- Core entities definitions
- Adapter pattern implementation
- ELT pipeline (Extract-Load-Transform)
- Technology stack
- Security & scalability considerations
- Implementation checklist

**👉 Đọc file này trước để hiểu tổng quan kiến trúc.**

---

### **2. [sync-strategy-recommendation.md](./sync-strategy-recommendation.md)**

Recommendation về sync strategy:
- So sánh Centralized vs Per-Tenant Landing Zone
- Recommendation: Centralized Landing Zone
- Implementation details
- Performance considerations
- Database structure

**👉 Đọc để hiểu tại sao chọn Centralized Landing Zone.**

---

### **3. [sync-flow-explanation.md](./sync-flow-explanation.md)**

Giải thích chi tiết flow và optimization:
- Flow đúng của hệ thống
- Tại sao cần WebhookUrl (và tại sao không cần nữa)
- Optimization: Enrich message tại Azure Function
- HIPAA encryption flow
- Code examples cho Azure Function và App

**👉 Đọc để hiểu flow và optimization strategy.**

---

### **4. [sync-mediatr-cqrs-examples.md](./sync-mediatr-cqrs-examples.md)** ⭐ **IMPLEMENTATION**

Code examples với MediatR CQRS pattern:
- Commands: ProcessWebhookCommand, ExtractDataCommand, LoadDataCommand, TransformDataCommand, SyncPatientCommand
- Queries: GetPmsConnectionByWebhookUrlQuery
- Pipeline Behaviors: ValidationBehavior, LoggingBehavior, TransactionBehavior
- Service Bus Consumer implementation
- Module configuration

**👉 Đọc để implement code theo MediatR CQRS pattern.**

---

### **5. [sync-monitoring-log-analysis.md](./sync-monitoring-log-analysis.md)**

Đánh giá và đề xuất cải thiện cho monitoring:
- Đánh giá bảng log hiện tại (PmsRawData, PmsSyncLog)
- Điểm mạnh và thiếu sót
- Đề xuất fields cần thêm cho monitoring
- Metrics cần track
- Updated entity structures

**👉 Đọc để hiểu monitoring requirements và cải thiện logging.**

---

## 🗑️ Files Không Cần Thiết (Có Thể Xóa)

### **1. architecture_review.md**
- ❌ **Xóa**: Nội dung đã được merge vào `sync-architecture.md`
- Lý do: Đánh giá ban đầu, giờ đã có architecture chi tiết hơn

### **2. sync-implementation-examples.md**
- ❌ **Xóa**: Code examples cũ (không dùng MediatR)
- Lý do: Đã có `sync-mediatr-cqrs-examples.md` với MediatR CQRS pattern

### **3. sync-optimization-webhookurl.md**
- ❌ **Xóa**: Nội dung đã được merge vào `sync-flow-explanation.md`
- Lý do: Optimization về WebhookUrl đã có trong flow explanation

---

## 📋 Reading Order (Thứ Tự Đọc)

### **Cho Architects/Technical Leads:**
1. `sync-architecture.md` - Hiểu tổng quan kiến trúc
2. `sync-strategy-recommendation.md` - Hiểu design decisions
3. `sync-flow-explanation.md` - Hiểu flow và optimization

### **Cho Developers:**
1. `sync-architecture.md` - Hiểu tổng quan
2. `sync-mediatr-cqrs-examples.md` - Implement code
3. `sync-monitoring-log-analysis.md` - Implement logging

### **Cho DevOps:**
1. `sync-architecture.md` - Hiểu infrastructure requirements
2. `sync-flow-explanation.md` - Hiểu Azure Function và Service Bus setup
3. `sync-monitoring-log-analysis.md` - Setup monitoring

---

## 🎯 Quick Reference

### **Kiến Trúc Chính:**
- **Pattern**: ELT (Extract-Load-Transform) với Adapter Pattern
- **Messaging**: Azure Service Bus (Topic + Subscription)
- **Webhook**: Azure Function (validate, encrypt, enrich)
- **Application**: ABP Framework với MediatR CQRS
- **Database**: Centralized Landing Zone (Master DB) + Per-Tenant DBs

### **Key Decisions:**
- ✅ **Centralized Landing Zone**: Raw data ở Master DB, transform vào Tenant DBs
- ✅ **Enrich tại Azure Function**: Metadata trong Service Bus message (không cần lookup DB ở app)
- ✅ **HIPAA Encryption**: Encrypt PII/PHI tại Azure Function, decrypt tại App
- ✅ **MediatR CQRS**: Commands/Queries thay vì Application Services

### **Core Entities:**
- `PmsConnection`: Tenant ↔ PMS mapping
- `PmsRawData`: Landing zone (raw JSON + extracted data)
- `PmsSyncLog`: Audit trail
- `PmsEntityMapping`: PMS ID → Tenant Entity ID mapping

### **ELT Pipeline:**
1. **Extract**: Parse PMS-specific JSON → RawData (via Adapter)
2. **Load**: Save to Landing Zone (PmsRawData) với idempotency check
3. **Transform**: Map RawData → Domain Entities (Patient, Appointment, TreatmentPlan)

---

## 📊 Monitoring & Observability

### **Metrics Cần Track:**
- Throughput: Messages per second, success/failure rate
- Performance: Average, P95, P99 processing time
- Errors: Error rate, error by type, retry rate
- Health: Queue depth, backlog, active connections

### **Logging:**
- `PmsRawData`: Track status, stages, durations
- `PmsSyncLog`: Audit trail với error details
- See `sync-monitoring-log-analysis.md` cho chi tiết

---

## 🔐 Security & Compliance

### **HIPAA Compliance:**
- Encrypt PII/PHI tại Azure Function (Azure Key Vault)
- Encryption at rest (Service Bus automatic)
- Decrypt tại App trước khi process
- Audit logging cho all operations

### **Security:**
- HMAC validation tại Azure Function
- Managed Identity cho Azure resources
- Tenant isolation (ABP multi-tenancy)
- Role-based access control

---

## 🚀 Implementation Checklist

Xem `sync-architecture.md` section "Implementation Checklist" cho chi tiết.

**High Level:**
- [ ] Phase 1: Foundation (entities, repositories)
- [ ] Phase 2: OpenDental Adapter
- [ ] Phase 3: ELT Pipeline với MediatR CQRS
- [ ] Phase 4: Service Bus Integration
- [ ] Phase 5: Azure Function (webhook receiver với encryption)
- [ ] Phase 6: Monitoring & Observability

---

## 📞 Support

Nếu có câu hỏi về:
- **Architecture**: Xem `sync-architecture.md`
- **Flow/Optimization**: Xem `sync-flow-explanation.md`
- **Implementation**: Xem `sync-mediatr-cqrs-examples.md`
- **Monitoring**: Xem `sync-monitoring-log-analysis.md`

---

## 📝 Changelog

- **2024-01**: Initial architecture design
- **2024-01**: Added MediatR CQRS pattern
- **2024-01**: Added HIPAA encryption flow
- **2024-01**: Added monitoring analysis

---

## ✅ Files Cần Giữ

1. ✅ `sync-architecture.md` - Kiến trúc chính
2. ✅ `sync-strategy-recommendation.md` - Design decisions
3. ✅ `sync-flow-explanation.md` - Flow & optimization
4. ✅ `sync-mediatr-cqrs-examples.md` - Code examples
5. ✅ `sync-monitoring-log-analysis.md` - Monitoring
6. ✅ `README.md` - This file (index)

## 🗑️ Files Có Thể Xóa

1. ❌ `architecture_review.md` - Đã merge vào sync-architecture.md
2. ❌ `sync-implementation-examples.md` - Đã thay bằng sync-mediatr-cqrs-examples.md
3. ❌ `sync-optimization-webhookurl.md` - Đã merge vào sync-flow-explanation.md

