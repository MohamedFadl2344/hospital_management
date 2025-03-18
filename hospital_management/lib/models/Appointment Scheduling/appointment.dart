class Appointment {
  String appointmentId;
  String patientId;
  String doctorId;
  DateTime appointmentDate;
  String appointmentTime;
  String status;
  String notes;
  bool reminderSent;

  Appointment({
    required this.appointmentId,
    required this.patientId,
    required this.doctorId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.status,
    required this.notes,
    required this.reminderSent,
  });

  void scheduleAppointment() {
    // Scheduling logic
    if (status == 'Scheduled') {
      print('Appointment is already scheduled for $patientId on $appointmentDate at $appointmentTime');
      return;
    }
    if (status == 'Pending') {
      status = 'Scheduled';
      reminderSent = true;
      print('Appointment successfully scheduled.');
    } else {
      print("Cannot schedule appointment, current status: $status.");
    }
  }

  void cancelAppointment() {
    // Cancellation logic
    if (status != 'Scheduled') {
      print('Cannot cancel appointment, current status: $status.');
      return;
    }
    status = 'Cancelled';
    reminderSent = false;
    print('The appointment was cancelled successfully!');
  }

  void updateAppointment(DateTime newDate, String newTime) {
    // Update logic
    if (status != 'Scheduled') {
      print('Cannot update appointment, current status: $status.');
      return;
    }
    appointmentDate = newDate;
    appointmentTime = newTime;
    print('The appointment was updated successfully!');
  }

  void sendReminder() {
    // Reminder logic
    if (reminderSent) {
      print('Reminder already sent.');
      return;
    }
    print('Sending reminder for appointment.');
    reminderSent = true;
  }

  void rescheduleAppointment(DateTime newDate, String newTime) {
    // Rescheduling logic
    if (status != 'Scheduled') {
      print('Cannot reschedule appointment, current status: $status.');
      return;
    }
    appointmentDate = newDate;
    appointmentTime = newTime;
    print('The appointment was rescheduled successfully!');
  }
}
