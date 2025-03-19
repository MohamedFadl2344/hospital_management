import '../../database/database.dart';

class Appointment {
  static List<Appointment> appointments = [];

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

  Map<String, dynamic> toJson() {
    return {
      'appointmentId': appointmentId,
      'patientId': patientId,
      'doctorId': doctorId,
      'appointmentDate': appointmentDate.toIso8601String(),
      'appointmentTime': appointmentTime,
      'status': status,
      'notes': notes,
      'reminderSent': reminderSent,
    };
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appointmentId: json['appointmentId'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      appointmentDate: DateTime.parse(json['appointmentDate']),
      appointmentTime: json['appointmentTime'],
      status: json['status'],
      notes: json['notes'],
      reminderSent: json['reminderSent'],
    );
  }

 static Appointment? getAppointmentById(String id) {
  try {
    return appointments.firstWhere((a) => a.appointmentId == id);
  } catch (e) {
    return null;
  }
}


  void scheduleAppointment() {
    if (status == 'Scheduled') {
      print('Appointment is already scheduled.');
      return;
    }
    status = 'Scheduled';
    reminderSent = true;
    Database.saveAppointments();
    print('Appointment successfully scheduled.');
  }

  void cancelAppointment() {
    if (status != 'Scheduled') {
      print('Cannot cancel appointment, current status: $status.');
      return;
    }
    status = 'Cancelled';
    reminderSent = false;
    Database.saveAppointments();
    print('The appointment was cancelled successfully!');
  }

  void updateAppointment(DateTime newDate, String newTime) {
    if (status != 'Scheduled') {
      print('Cannot update appointment, current status: $status.');
      return;
    }
    appointmentDate = newDate;
    appointmentTime = newTime;
    Database.saveAppointments();
    print('The appointment was updated successfully!');
  }
}
