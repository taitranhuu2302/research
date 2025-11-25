using System;
using Dental.Common.Attributes;

namespace Dental.TreatmentTracker.ValueObjects;

public record PatientData
{
    public PatientData()
    {
    }

    public PatientData(string? patientPmsId, string? avatarUrl, string? name, string? marketingSource,
        DateTime? dateOfBirth, string? haveInsurance, string? insuranceCompany, string? phoneNumber, string? zipCode,
        string? gender, string? maritalStatus, string? spouseName, bool? haveChildren, bool? haveGrandchildren,
        string? occupation, string? hobbies, string? referralName)
    {
        PatientPmsId = patientPmsId;
        AvatarUrl = avatarUrl;
        Name = name;
        MarketingSource = marketingSource;
        DateOfBirth = dateOfBirth;
        InsuranceCompany = insuranceCompany;
        PhoneNumber = phoneNumber;
        ZipCode = zipCode;
        Gender = gender;
        MaritalStatus = maritalStatus;
        SpouseName = spouseName;
        HaveChildren = haveChildren.GetValueOrDefault();
        HaveGrandchildren = haveGrandchildren.GetValueOrDefault();
        Occupation = occupation;
        Hobbies = hobbies;
        ReferralName = referralName;
        HaveInsurance = haveInsurance;
    }

    public string? PatientPmsId { get; set; }
    [Encrypted] public string? AvatarUrl { get; set; }

    [Encrypted]
    [Hashable(TargetProperty = nameof(NameHash))]
    public string? Name { get; set; }

    public string? NameHash { get; set; }

    public string? MarketingSource { get; set; }

    [Encrypted] public string? ReferralName { get; set; }

    [Encrypted] public DateTime? DateOfBirth { get; set; }

    public string? HaveInsurance { get; set; }
    public string? InsuranceCompany { get; set; }

    [Encrypted] public string? PhoneNumber { get; set; }
    [Encrypted] public string? ZipCode { get; set; }
    [Encrypted] public string? Gender { get; set; }
    [Encrypted] public string? MaritalStatus { get; set; }
    [Encrypted] public string? SpouseName { get; set; }
    [Encrypted] public bool? HaveChildren { get; set; }
    [Encrypted] public bool? HaveGrandchildren { get; set; }
    [Encrypted] public string? Occupation { get; set; }
    [Encrypted] public string? Hobbies { get; set; }
}
