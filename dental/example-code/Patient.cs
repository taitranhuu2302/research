using System;
using System.Collections.Generic;
using Dental.TreatmentTracker.ValueObjects;
using Volo.Abp.Auditing;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;

namespace Dental.TreatmentTracker.Entities;

public class Patient : FullAuditedAggregateRoot<long>, IMultiTenant
{
    private Patient()
    {
    }

    public Patient(PatientData? data, string? patientPmsId)
    {
        Data = data;
        PatientPmsId = patientPmsId;
    }

    public Patient(PatientData? data, string? patientPmsId, Guid? tenantId)
    {
        Data = data;
        PatientPmsId = patientPmsId;
        TenantId = tenantId;
    }

    [DisableAuditing] public PatientData? Data { get; private set; }

    public ICollection<TreatmentPlan> TreatmentPlans { get; private set; } = new List<TreatmentPlan>();

    public string? PatientPmsId { get; private set; }
    public DateTime? LatestPmsSync { get; private set; }
    public Guid? TenantId { get; set; }

    public void Modify(PatientData? data)
    {
        Data = data;
        PatientPmsId = data?.PatientPmsId;
    }

    public void SetAvatarUrl(string? avatarUrl)
    {
        if (Data is null)
        {
            return;
        }

        Data = Data with { AvatarUrl = avatarUrl };
    }

    public void RemoveAvatarUrl()
    {
        if (Data is null)
        {
            return;
        }

        Data = Data with { AvatarUrl = null };
    }
}
