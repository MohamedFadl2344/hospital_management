import 'dart:io';
import 'database/database.dart';
import 'models/Appointment Scheduling/appointment.dart';

void main() {
  Database.loadAppointments();

  while (true) {
    print("\n========== Appointment Scheduling System ==========");
    print("1. Schedule Appointment");
    print("2. Cancel Appointment");
    print("3. Update Appointment");
    print("4. Exit");
    stdout.write("Enter your choice: ");

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        scheduleAppointment();
        break;
      case '2':
        cancelAppointment();
        break;
      case '3':
        updateAppointment();
        break;
      case '4':
        print("Exiting...");
        return;
      default:
        print("Invalid choice! Try again.");
    }
  }
}

void scheduleAppointment() {
  stdout.write("Enter Patient ID: ");
  String patientId = stdin.readLineSync()!;

  stdout.write("Enter Doctor ID: ");
  String doctorId = stdin.readLineSync()!;

  stdout.write("Enter Appointment Date (YYYY-MM-DD): ");
  DateTime appointmentDate = DateTime.parse(stdin.readLineSync()!);

  stdout.write("Enter Appointment Time (HH:MM): ");
  String appointmentTime = stdin.readLineSync()!;

  String appointmentId = DateTime.now().millisecondsSinceEpoch.toString();

  Appointment newAppointment = Appointment(
    appointmentId: appointmentId,
    patientId: patientId,
    doctorId: doctorId,
    appointmentDate: appointmentDate,
    appointmentTime: appointmentTime,
    status: "Pending",
    notes: "",
    reminderSent: false,
  );

  Appointment.appointments.add(newAppointment);
  print("New Appointment Added: ${newAppointment.toJson()}");
  newAppointment.scheduleAppointment();
  Database.saveAppointments();
}

void cancelAppointment() {
  stdout.write("Enter Appointment ID to cancel: ");
  String id = stdin.readLineSync()!;
  Appointment? appointment = Appointment.getAppointmentById(id);

  if (appointment != null) {
    appointment.cancelAppointment();
    Database.saveAppointments();
  } else {
    print("Appointment not found.");
  }
}

void updateAppointment() {
  stdout.write("Enter Appointment ID to update: ");
  String id = stdin.readLineSync()!;
  Appointment? appointment = Appointment.getAppointmentById(id);

  if (appointment != null) {
    stdout.write("Enter New Date (YYYY-MM-DD): ");
    DateTime newDate = DateTime.parse(stdin.readLineSync()!);

    stdout.write("Enter New Time (HH:MM): ");
    String newTime = stdin.readLineSync()!;

    appointment.updateAppointment(newDate, newTime);
    Database.saveAppointments();
  } else {
    print("Appointment not found.");
  }
}
