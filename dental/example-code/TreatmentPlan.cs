using System;
using System.Collections.Generic;
using System.Linq;
using Dental.TreatmentTracker.Enums;
using Dental.TreatmentTracker.Events;
using Dental.TreatmentTracker.ValueObjects;
using Volo.Abp.Auditing;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;

namespace Dental.TreatmentTracker.Entities;

public class TreatmentPlan : FullAuditedAggregateRoot<long>, IMultiTenant
{
    private TreatmentPlan()
    {
    }

    public TreatmentPlan(TreatmentPlanData? data, long navigatorFormId)
    {
        Data = data;
        NavigatorFormId = navigatorFormId;
    }

    [DisableAuditing]
    public TreatmentPlanData? Data { get; private set; }

    public long? PatientId { get; private set; }
    public Patient? Patient { get; private set; }

    public long NavigatorFormId { get; private set; }
    public NavigatorForm? NavigatorForm { get; private set; }
    public Guid? TenantId { get; set; }

    public ICollection<NavigatorFormSubmission> NavigatorFormSubmissions { get; } =
        new List<NavigatorFormSubmission>();
    
    public ICollection<StageProgress> StageProgress { get; private set; } = new List<StageProgress>();

    public void MarkDeleted()
    {
        AddLocalEvent(new RemoveTreatmentPlanEvent(Id, TenantId));
    }

    public void SetPatient(Patient patient)
    {
        Patient = patient;
    }

    public void Modify(TreatmentPlanData? data)
    {
        Data = data;
    }

    public void SetStageProgress(List<StageProgress> stageProgress)
    {
        StageProgress = stageProgress;
    }

    public void AddNavigatorFormSubmission(NavigatorFormSubmission navigatorFormSubmission)
    {
        NavigatorFormSubmissions.Add(navigatorFormSubmission);
    }

    public void UpdateStatus(bool isActive)
    {
        Data ??= new TreatmentPlanData();

        if (Data.IsActive == isActive)
        {
            return;
        }

        Data = Data with
        {
            IsActive = isActive
        };
    }

    public TreatmentPlanStatus? GetStatus()
    {
        // Return Wait if there are no stage progresses
        if (StageProgress.Count == 0)
        {
            return TreatmentPlanStatus.Wait;
        }

        // Sort all stages by Order in ascending order
        var orderedStages = StageProgress
            .Where(s => s.Data != null)
            .OrderBy(s => s.Data!.Order)
            .ToList();

        // If no stages exist, return Wait
        if (!orderedStages.Any())
        {
            return TreatmentPlanStatus.Wait;
        }

        // Done: Has at least one final stage that is fully completed
        if (orderedStages.Any(s => s.Data!.StartDate != null && s.Data.EndDate != null && s.Data.IsFinal))
        {
            return TreatmentPlanStatus.Done;
        }

        // Active: Has at least one stage with StartDate but no EndDate (currently in progress)
        if (orderedStages.Any(s => s.Data!.StartDate != null && s.Data.EndDate == null))
        {
            return TreatmentPlanStatus.Active;
        }

        // Wait: Has stages waiting to start (no StartDate but all previous stages are completed)
        var hasWaitingStages = orderedStages.Any(currentStage =>
            currentStage.Data!.StartDate == null && // This stage hasn't started
            orderedStages
                .Where(s => s.Data!.Order < currentStage.Data!.Order) // All previous stages
                .All(s => s.Data!.StartDate != null && s.Data!.EndDate != null)); // Are completed

        if (hasWaitingStages)
        {
            return TreatmentPlanStatus.Wait;
        }

        // Default case: if no clear status can be determined, return Wait
        return TreatmentPlanStatus.Wait;
    }

    public StageProgress? GetCurrentStageProgress()
    {
        // Return null if there are no stage progresses
        if (StageProgress.Count == 0)
        {
            return null;
        }

        // Sort all stages by Order in ascending order
        var orderedStages = StageProgress
            .Where(s => s.Data != null)
            .OrderBy(s => s.Data!.Order)
            .ToList();

        // If no stages exist, return null
        if (!orderedStages.Any())
        {
            return null;
        }

        // Scenario 1: Find any stage that has StartDate but no EndDate (currently in progress)
        var currentlyInProgress = orderedStages
            .FirstOrDefault(s => s.Data!.StartDate != null && s.Data.EndDate == null);

        if (currentlyInProgress != null)
        {
            return currentlyInProgress;
        }

        // Scenario 2: If all stages have both StartDate and EndDate (all completed)
        if (orderedStages.All(s => s.Data!.StartDate != null && s.Data.EndDate != null))
        {
            // Return the last stage (highest order)
            return orderedStages.LastOrDefault();
        }

        // Scenario 3: Find the next stage that should start
        // Look for a stage that hasn't started yet, but all previous stages are completed
        var nextStageToStart = orderedStages
            .FirstOrDefault(currentStage =>
                currentStage.Data!.StartDate == null && // This stage hasn't started
                orderedStages
                    .Where(s => s.Data!.Order < currentStage.Data!.Order) // All previous stages
                    .All(s => s.Data!.StartDate != null && s.Data!.EndDate != null)); // Are completed

        if (nextStageToStart != null)
        {
            return nextStageToStart;
        }

        // If no stage has been started yet, return the first stage
        return orderedStages.FirstOrDefault();
    }

    public StageProgress? GetPreviousStageProgress()
    {
        if (StageProgress.Count == 0)
        {
            return null;
        }

        var orderedStages = StageProgress
            .Where(s => s.Data != null)
            .OrderBy(s => s.Data!.Order)
            .ToList();

        if (!orderedStages.Any())
        {
            return null;
        }

        var currentStage = GetCurrentStageProgress();
        if (currentStage == null)
        {
            return null;
        }

        return orderedStages.LastOrDefault(s => s.Data!.Order < currentStage.Data!.Order);
    }

}
