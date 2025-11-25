using System;
using MGI.Clinical.Appointments.Enums;
using MGI.Clinical.Common.ValueObjects;
using MGI.Clinical.Patients;
using MGI.Clinical.Patients.Enums;
using Volo.Abp.Domain.Entities.Auditing;
using Volo.Abp.MultiTenancy;

namespace Dental.TreatmentTracker.Entities;

public class Appointment : FullAuditedAggregateRoot<Guid>, IMultiTenant
{
	private Appointment()
	{
	}

	public Appointment(Guid patientId, Guid? providerId, DateTime? date, int? duration, AppointmentType? type,
		AppointmentStatus? status, PatientTone? patientToneOption, string? conversationNotes,
		BookingSourceType? bookingSource,
		string? notes)
	{
		PatientId = patientId;
		ProviderId = providerId;
		Date = date;
		Duration = duration;
		Type = type;
		Status = status;
		PatientToneOption = patientToneOption;
		ConversationNotes = conversationNotes;
		BookingSource = bookingSource;
		Notes = notes;
	}

	public Guid PatientId { get; private set; }
	public Patient Patient { get; private set; }

	public Guid? ProviderId { get; private set; }

	public DateTime? Date { get; private set; }
	public int? Duration { get; private set; }
	public AppointmentType? Type { get; private set; }
	public string? TypeHash { get; private set; }
	public AppointmentStatus? Status { get; private set; }
	public string? StatusHash { get; private set; }
	public PatientTone? PatientToneOption { get; private set; }
	public string? PatientToneOptionHash { get; private set; }

	public string? ConversationNotes { get; private set; }
	public BookingSourceType? BookingSource { get; private set; }

	public Guid? RescheduleById { get; private set; }
	public string? RescheduleReason { get; private set; }
	public DateTime? RescheduledAt { get; private set; }
	public RescheduleSide? RescheduleSide { get; private set; }

	public Guid? CanceledById { get; private set; }
	public string? CanceledReason { get; private set; }
	public DateTime? CanceledAt { get; private set; }

	public DateTime? CheckinAt { get; private set; }
	public string? ArrivalNotes { get; private set; }
	public string? Notes { get; private set; }

	public DateTime? CompletedAt { get; private set; }
	public Guid? CompletedById { get; private set; }

	public DateTime? StartAt { get; private set; }
	public Guid? StartById { get; private set; }

	public HandOff HandOff { get; private set; } = HandOff.Empty();

	public Guid? TenantId { get; set; }

	public void SetTypeHash(string typeHash)
	{
		TypeHash = typeHash;
	}

	public void SetStatusHash(string statusHash)
	{
		StatusHash = statusHash;
	}

	public void SetPatientToneOptionHash(string patientToneOptionHash)
	{
		PatientToneOptionHash = patientToneOptionHash;
	}

	/// <summary>
	/// Updates hash values for enum fields.
	/// Called internally by domain methods to keep hashes in sync.
	/// </summary>
	public void UpdateHashes(string typeHash, string statusHash, string patientToneOptionHash)
	{
		TypeHash = typeHash;
		StatusHash = statusHash;
		PatientToneOptionHash = patientToneOptionHash;
	}

	/// <summary>
	/// Reschedules the appointment to a new date and time.
	/// </summary>
	/// <param name="newDate">New appointment date and time.</param>
	/// <param name="newDuration">New appointment duration in minutes.</param>
	/// <param name="newProviderId">New provider identifier.</param>
	/// <param name="newType">New appointment type.</param>
	/// <param name="newPatientToneOption">New patient tone option.</param>
	/// <param name="newConversationNotes">New conversation notes.</param>
	/// <param name="rescheduleReason">Reason for rescheduling.</param>
	/// <param name="rescheduleSide">Side that initiated the reschedule (Practice or Patient).</param>
	/// <param name="rescheduledById">User who initiated the reschedule.</param>
	/// <param name="rescheduledAt">Date and time when the reschedule occurred.</param>
	public void Reschedule(
		DateTime newDate,
		int newDuration,
		Guid newProviderId,
		AppointmentType newType,
		PatientTone newPatientToneOption,
		string newConversationNotes,
		string rescheduleReason,
		RescheduleSide rescheduleSide,
		Guid rescheduledById,
		DateTime rescheduledAt)
	{
		Date = newDate;
		Duration = newDuration;
		ProviderId = newProviderId;
		Type = newType;
		PatientToneOption = newPatientToneOption;
		ConversationNotes = newConversationNotes;
		RescheduleReason = rescheduleReason;
		RescheduleSide = rescheduleSide;
		RescheduleById = rescheduledById;
		RescheduledAt = rescheduledAt;
		Status = AppointmentStatus.Scheduled;
	}

	/// <summary>
	/// Cancels the appointment.
	/// </summary>
	/// <param name="canceledReason">Reason for canceling the appointment.</param>
	/// <param name="patientToneOption">Observed patient tone captured during the cancellation conversation.</param>
	/// <param name="conversationNotes">Summary of the conversation that occurred while canceling the appointment.</param>
	/// <param name="canceledById">User who initiated the cancellation.</param>
	/// <param name="canceledAt">Date and time when the cancellation occurred.</param>
	public void Cancel(
		string canceledReason,
		PatientTone patientToneOption,
		string conversationNotes,
		Guid canceledById,
		DateTime canceledAt)
	{
		CanceledReason = canceledReason;
		PatientToneOption = patientToneOption;
		ConversationNotes = conversationNotes;
		CanceledById = canceledById;
		CanceledAt = canceledAt;
		Status = AppointmentStatus.Canceled;
	}

	/// <summary>
	/// Marks the appointment as no-show.
	/// </summary>
	/// <param name="notes">Additional notes captured when marking the appointment as no-show.</param>
	public void MarkAsNoShow(string notes)
	{
		Notes = notes;
		Status = AppointmentStatus.NoShowed;
	}

	/// <summary>
	/// Checks in the appointment.
	/// </summary>
	/// <param name="arrivalNotes">Notes captured when the patient arrived for the appointment.</param>
	/// <param name="patientToneOption">Observed patient tone captured during the check-in conversation.</param>
	/// <param name="conversationNotes">Summary of the conversation that occurred while checking in the appointment.</param>
	/// <param name="checkinAt">Date and time when the check-in occurred.</param>
	/// <param name="handleBy"></param>
	public void CheckIn(
		string arrivalNotes,
		PatientTone patientToneOption,
		string conversationNotes,
		DateTime checkinAt,
		Guid handleBy)
	{
		ArrivalNotes = arrivalNotes;
		PatientToneOption = patientToneOption;
		ConversationNotes = conversationNotes;
		CheckinAt = checkinAt;
		Status = AppointmentStatus.Arrived;
		HandOff = HandOff.Update(handleBy: handleBy, handleOffBy: null, notifyTo: null, handedOffAt: null,
			arrivalHandOffNotes: null);
	}

	/// <summary>
	/// Starts the appointment, marking it as in progress.
	/// </summary>
	/// <param name="startedById">User who started the appointment.</param>
	/// <param name="startedAt">Date and time when the appointment was started.</param>
	/// <param name="notes">Optional notes captured when starting the appointment.</param>
	public void Start(Guid startedById, DateTime startedAt, string? notes = null)
	{
		if (!string.IsNullOrWhiteSpace(notes))
		{
			Notes = notes;
		}

		StartById = startedById;
		StartAt = startedAt;
		Status = AppointmentStatus.InProgress;
	}

	/// <summary>
	/// Completes the appointment.
	/// </summary>
	/// <param name="notes">Additional notes captured when completing the appointment.</param>
	/// <param name="completedById">User who completed the appointment.</param>
	/// <param name="completedAt">Date and time when the appointment was completed.</param>
	public void Complete(string? notes, Guid completedById, DateTime completedAt)
	{
		if (!string.IsNullOrWhiteSpace(notes))
		{
			Notes = notes;
		}

		CompletedById = completedById;
		CompletedAt = completedAt;
		Status = AppointmentStatus.Completed;
	}

	/// <summary>
	/// Performs hand-off of the appointment to a staff member.
	/// </summary>
	/// <param name="handedOffBy">User who initiated the hand-off.</param>
	/// <param name="notifyTo">Staff member who will receive the hand-off notification.</param>
	/// <param name="handOffAt">Date and time when the hand-off occurred.</param>
	/// <param name="arrivalNotes">Optional notes captured during the hand-off process.</param>
	public void PerformHandOff(
		Guid handedOffBy,
		Guid notifyTo,
		DateTime handOffAt,
		string? arrivalNotes = null)
	{
		HandOff = HandOff.Update(
			handleBy: HandOff.HandleBy,
			handleOffBy: handedOffBy,
			notifyTo: notifyTo,
			handedOffAt: handOffAt,
			arrivalHandOffNotes: arrivalNotes);
	}
}