using System;
using Dental.Common.Attributes;
using Dental.TreatmentTracker.Constants;
using PerformanceLifeCycleConstants = Dental.TreatmentTracker.Constants.PerformanceLifeCycle;

namespace Dental.TreatmentTracker.ValueObjects;

public record TreatmentPlanData
{
    public TreatmentPlanData()
    {
    }

    public TreatmentPlanData(string? examType, string? txDiagnosed, decimal? valueTxDiagnosed, string? txPresented,
        decimal? valueTxPresented, string? decoySafeOpenSafe, string? acceptanceStatus, string? tpRejectedReason,
        string? txAccepted, decimal? valueTxAccepted, string? unacceptedTx, decimal? valueUnacceptedTx,
        string? declinedTx, decimal? valueDeclinedTx, bool? coOpClose, bool? standInDelivery,
        bool? informedConsentsIcSigned, bool? csGivenToPatient,
        DateTime? whenWillTheyScheduleToPay, decimal? valueTxScheduled, bool? paidInFull, string? patientCategory,
        decimal? patientPortionOfTotalPlan, decimal? insurancePortion, bool? financing,
        string? financialArrangement, bool? paidSameDay, decimal? paidSameDateValue, string? followUpNeeded,
        string? tcPresentedTx, decimal? valueTcPresentedTx, string? deferredTx, decimal? valueDeferredTx,
        string? financialStatus, bool? isSameDateTx, decimal? percentCompleted, string? currentStage,
        Guid? currentInCharged,
        string? hygienePresentedTx, decimal? valueHygienePresentedTx,
        DateTime? dateScheduled, DateTime? checkInFirstVisitDate, string? firstVisitAssignment,
        string? prophyStatus, string? presentedType)
    {
        ExamType = examType;
        TxDiagnosed = txDiagnosed;
        ValueTxDiagnosed = valueTxDiagnosed;
        TxPresented = txPresented;
        ValueTxPresented = valueTxPresented;
        DecoySafeOpenSafe = decoySafeOpenSafe;
        AcceptanceStatus = acceptanceStatus;
        TpRejectedReason = tpRejectedReason;
        TxAccepted = txAccepted;
        ValueTxAccepted = valueTxAccepted;
        UnacceptedTx = unacceptedTx;
        ValueUnacceptedTx = valueUnacceptedTx;
        DeclinedTx = declinedTx;
        ValueDeclinedTx = valueDeclinedTx;
        CoOpClose = coOpClose.GetValueOrDefault();
        StandInDelivery = standInDelivery.GetValueOrDefault();
        InformedConsentsIcSigned = informedConsentsIcSigned.GetValueOrDefault();
        CsGivenToPatient = csGivenToPatient.GetValueOrDefault();
        WhenWillTheyScheduleToPay = whenWillTheyScheduleToPay;
        ValueTxScheduled = valueTxScheduled;
        PaidInFull = paidInFull.GetValueOrDefault();
        PatientCategory = patientCategory;
        PatientPortionOfTotalPlan = patientPortionOfTotalPlan;
        InsurancePortion = insurancePortion;
        Financing = financing.GetValueOrDefault();
        FinancialArrangement = financialArrangement;
        PaidSameDay = paidSameDay.GetValueOrDefault();
        PaidSameDateValue = paidSameDateValue;
        FollowUpNeeded = followUpNeeded;
        TcPresentedTx = tcPresentedTx;
        ValueTcPresentedTx = valueTcPresentedTx;
        DeferredTx = deferredTx;
        ValueDeferredTx = valueDeferredTx;
        FinancialStatus = financialStatus;
        IsSameDateTx = isSameDateTx.GetValueOrDefault();
        PercentCompleted = percentCompleted;
        CurrentStage = currentStage;
        CurrentInCharged = currentInCharged;
        HygienePresentedTx = hygienePresentedTx;
        ValueHygienePresentedTx = valueHygienePresentedTx;
        DateScheduled = dateScheduled;
        CheckInFirstVisitDate = checkInFirstVisitDate;
        FirstVisitAssignment = firstVisitAssignment;
        ProphyStatus = prophyStatus;
        PresentedType = presentedType;
        IsActive = true;
        CalculateAcceptanceRate();
    }


    public string? ExamType { get; set; }
    [Encrypted] public string? TxDiagnosed { get; set; }
    public decimal? ValueTxDiagnosed { get; set; }
    [Encrypted] public string? TxPresented { get; set; }
    public decimal? ValueTxPresented { get; set; }
    public string? DecoySafeOpenSafe { get; set; }
    public string? AcceptanceStatus { get; set; }
    [Encrypted] public string? TpRejectedReason { get; set; }
    [Encrypted] public string? TxAccepted { get; set; }
    public decimal? ValueTxAccepted { get; set; }
    [Encrypted] public string? UnacceptedTx { get; set; }
    public decimal? ValueUnacceptedTx { get; set; }
    [Encrypted] public string? DeclinedTx { get; set; }
    public decimal? ValueDeclinedTx { get; set; }
    public bool? CoOpClose { get; set; }
    public bool? StandInDelivery { get; set; }
    public bool? InformedConsentsIcSigned { get; set; }
    public bool? CsGivenToPatient { get; set; }
    public DateTime? WhenWillTheyScheduleToPay { get; set; }
    public decimal? ValueTxScheduled { get; set; }
    public bool? PaidInFull { get; set; }
    public string? PatientCategory { get; set; }
    public decimal? PatientPortionOfTotalPlan { get; set; }
    public decimal? InsurancePortion { get; set; }
    public bool? Financing { get; set; }
    public string? FinancialArrangement { get; set; }
    public bool? PaidSameDay { get; set; }
    public bool? IsSameDateTx { get; set; }
    public decimal? PaidSameDateValue { get; set; }
    [Encrypted] public string? FollowUpNeeded { get; set; }
    [Encrypted] public string? TcPresentedTx { get; set; }
    public decimal? ValueTcPresentedTx { get; set; }
    [Encrypted] public string? DeferredTx { get; set; }
    public decimal? ValueDeferredTx { get; set; }
    public string? FinancialStatus { get; set; }
    public decimal? PercentCompleted { get; set; }
    public string? CurrentStage { get; set; }
    public Guid? CurrentInCharged { get; set; }
    public decimal? AcceptanceRate { get; set; }

    [Encrypted] public string? HygienePresentedTx { get; set; }
    public decimal? ValueHygienePresentedTx { get; set; }
    public DateTime? DateScheduled { get; set; }
    public DateTime? CheckInFirstVisitDate { get; set; }
    public string? FirstVisitAssignment { get; set; }
    public string? ProphyStatus { get; set; }
    public string? PresentedType { get; set; }
    public bool IsActive { get; set; } = true;

    public void CalculateAcceptanceRate()
    {
        if (ValueTxPresented.HasValue && ValueTxAccepted.HasValue && ValueTxPresented.Value > 0)
        {
            AcceptanceRate = ValueTxAccepted.Value / ValueTxPresented.Value * 100;
        }
        else
        {
            AcceptanceRate = 0m;
        }
    }

    #region Business Logic Methods

    // Schedule and Check-in Status
    public bool HasScheduledDate()
    {
        return DateScheduled.HasValue;
    }

    public bool HasCheckedIn()
    {
        return CheckInFirstVisitDate.HasValue;
    }

    // First Visit Assignment
    public bool IsFirstVisitDoctor()
    {
        return FirstVisitAssignment == PerformanceLifeCycleConstants.FirstVisitAssignment.Doctor;
    }

    public bool IsFirstVisitHygienist()
    {
        return FirstVisitAssignment == PerformanceLifeCycleConstants.FirstVisitAssignment.Hygienist;
    }

    public bool IsUnassignedFirstVisit()
    {
        return string.IsNullOrEmpty(FirstVisitAssignment);
    }

    // Prophy Status
    public bool IsReceivedCleaning()
    {
        return ProphyStatus == PerformanceLifeCycleConstants.ProphyStatus.ReceivedCleaning;
    }

    public bool IsFlaggedForPerioNoCleaning()
    {
        return ProphyStatus == PerformanceLifeCycleConstants.ProphyStatus.FlaggedForPerioNoCleaning;
    }

    public bool IsProphyStatusNotRecorded()
    {
        return string.IsNullOrEmpty(ProphyStatus);
    }

    // Exam Types
    public bool IsComprehensiveExam()
    {
        return ExamType == PerformanceLifeCycleConstants.ExamType.Comprehensive;
    }

    public bool IsLimitedExam()
    {
        return ExamType == PerformanceLifeCycleConstants.ExamType.Limited;
    }

    // Value Checks
    public bool HasValueTxDiagnosed()
    {
        return ValueTxDiagnosed is > 0;
    }

    public bool HasValueTxPresented()
    {
        return ValueTxPresented is > 0;
    }

    public bool HasValueTcPresentedTx()
    {
        return ValueTcPresentedTx is > 0;
    }

    public bool HasValueDeferredTx()
    {
        return ValueDeferredTx is > 0;
    }

    public bool HasValueUnAcceptedTx()
    {
        return ValueUnacceptedTx is > 0;
    }

    public bool HasValueTxAccepted()
    {
        return ValueTxAccepted is > 0;
    }

    public bool HasValueTxDeclined()
    {
        return ValueDeclinedTx is > 0;
    }

    // Presentation Types
    public bool IsComprehensivePresentation()
    {
        return PresentedType == PerformanceLifeCycleConstants.PresentedType.Comprehensive;
    }

    public bool IsPartiallyPresentation()
    {
        return PresentedType == PerformanceLifeCycleConstants.PresentedType.Partially;
    }

    // Acceptance Status
    public bool IsFullyAccepted()
    {
        return ValueTxAccepted.HasValue && ValueTxPresented.HasValue &&
               ValueTxAccepted.Value == ValueTxPresented.Value && ValueTxAccepted.Value > 0;
    }

    public bool IsPartiallyAccepted()
    {
        return ValueTxAccepted.HasValue && ValueTxPresented.HasValue &&
               ValueTxAccepted.Value < ValueTxPresented.Value && ValueTxAccepted.Value > 0;
    }

    public bool IsCompletelyDeclined()
    {
        return ValueDeclinedTx.HasValue && ValueTxPresented.HasValue &&
               ValueDeclinedTx.Value == ValueTxPresented.Value &&
               AcceptanceStatus == PerformanceLifeCycleConstants.AcceptanceStatus.TxRejected;
    }

    // Financial Status
    public bool HasSignedFinancialAgreement()
    {
        return FinancialStatus == PerformanceLifeCycleConstants.FinancialStatus.FinancialAgreementAndSigned;
    }

    public bool HasPendingFinancialAgreement()
    {
        return FinancialStatus == PerformanceLifeCycleConstants.FinancialStatus.PendingFinancialAgreement;
    }

    public bool HasInProgressFinanceAgreement()
    {
        return FinancialStatus == PerformanceLifeCycleConstants.FinancialStatus.InProgressFinanceAgreement;
    }

    public bool HasNoFinancialArrangement()
    {
        return string.IsNullOrEmpty(FinancialStatus);
    }

    // Acceptance Status
    public bool IsAcceptanceTxRejected()
    {
        return AcceptanceStatus == PerformanceLifeCycleConstants.AcceptanceStatus.TxRejected;
    }

    public bool IsAcceptanceTxAcceptedAndSigned()
    {
        return AcceptanceStatus == PerformanceLifeCycleConstants.AcceptanceStatus.TxAcceptedAndSigned;
    }

    public bool IsAcceptancePendingFinancial()
    {
        return AcceptanceStatus == PerformanceLifeCycleConstants.AcceptanceStatus.PendingFinancial;
    }

    public bool IsAcceptanceInProgress()
    {
        return AcceptanceStatus == PerformanceLifeCycleConstants.AcceptanceStatus.InProgress;
    }

    public bool IsNoAcceptanceStatus()
    {
        return string.IsNullOrEmpty(AcceptanceStatus);
    }

    // Payment Status
    public bool HasPaidOnFirstVisit()
    {
        return PaidSameDateValue > 0;
    }

    public bool HasNoPaymentOnFirstVisit()
    {
        return PaidSameDateValue is null or 0m;
    }

    // Treatment Status
    public bool HasStartedSameDayTx()
    {
        return IsSameDateTx == true;
    }

    public bool HasStandInDelivery()
    {
        return StandInDelivery == true;
    }

    public bool HasNoSameDayTxOrStandInDelivery()
    {
        return IsSameDateTx == false && StandInDelivery == false;
    }

    #endregion
}
