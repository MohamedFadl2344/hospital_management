import 'dart:io';
import 'models/Appointment Scheduling/appointment.dart';

void main() {
  List<Appointment> appointments = [];

  while (true) {
    print("\n========== Appointment Scheduling System ==========");
    print("1. Schedule Appointment");
    print("2. Cancel Appointment");
    print("3. Update Appointment");
    print("4. Send Reminder");
    print("5. Reschedule Appointment");
    print("6. Exit");
    stdout.write("Enter your choice: ");

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write("Enter Patient ID: ");
        String? patientId = stdin.readLineSync();
        stdout.write("Enter Doctor ID: ");
        String? doctorId = stdin.readLineSync();
        stdout.write("Enter Appointment Date (YYYY-MM-DD): ");
        String? dateInput = stdin.readLineSync();
        stdout.write("Enter Appointment Time (HH:MM): ");
        String? timeInput = stdin.readLineSync();

        if (patientId != null &&
            doctorId != null &&
            dateInput != null &&
            timeInput != null) {
          DateTime appointmentDate = DateTime.parse(dateInput);
          String appointmentId =
              DateTime.now().millisecondsSinceEpoch.toString();

          Appointment newAppointment = Appointment(
            appointmentId: appointmentId,
            patientId: patientId,
            doctorId: doctorId,
            appointmentDate: appointmentDate,
            appointmentTime: timeInput,
            status: "Pending",
            notes: "",
            reminderSent: false,
          );

          appointments.add(newAppointment);
          newAppointment.scheduleAppointment();
        }
        break;

      case '2':
        stdout.write("Enter Appointment ID to cancel: ");
        String? id = stdin.readLineSync();
        var appointment = appointments.firstWhere((a) => a.appointmentId == id,
            orElse: () => Appointment(
                appointmentId: "",
                patientId: "",
                doctorId: "",
                appointmentDate: DateTime.now(),
                appointmentTime: "",
                status: "",
                notes: "",
                reminderSent: false));

        if (appointment.appointmentId.isNotEmpty) {
          appointment.cancelAppointment();
        } else {
          print("Appointment not found.");
        }
        break;

      case '3':
        stdout.write("Enter Appointment ID to update: ");
        String? id = stdin.readLineSync();
        var appointment = appointments.firstWhere((a) => a.appointmentId == id,
            orElse: () => Appointment(
                appointmentId: "",
                patientId: "",
                doctorId: "",
                appointmentDate: DateTime.now(),
                appointmentTime: "",
                status: "",
                notes: "",
                reminderSent: false));

        if (appointment.appointmentId.isNotEmpty) {
          stdout.write("Enter New Date (YYYY-MM-DD): ");
          String? newDate = stdin.readLineSync();
          stdout.write("Enter New Time (HH:MM): ");
          String? newTime = stdin.readLineSync();
          if (newDate != null && newTime != null) {
            appointment.updateAppointment(DateTime.parse(newDate), newTime);
          }
        } else {
          print("Appointment not found.");
        }
        break;

      case '4':
        stdout.write("Enter Appointment ID to send reminder: ");
        String? id = stdin.readLineSync();
        var appointment = appointments.firstWhere((a) => a.appointmentId == id,
            orElse: () => Appointment(
                appointmentId: "",
                patientId: "",
                doctorId: "",
                appointmentDate: DateTime.now(),
                appointmentTime: "",
                status: "",
                notes: "",
                reminderSent: false));

        if (appointment.appointmentId.isNotEmpty) {
          appointment.sendReminder();
        } else {
          print("Appointment not found.");
        }
        break;

      case '5':
        stdout.write("Enter Appointment ID to reschedule: ");
        String? id = stdin.readLineSync();
        var appointment = appointments.firstWhere((a) => a.appointmentId == id,
            orElse: () => Appointment(
                appointmentId: "",
                patientId: "",
                doctorId: "",
                appointmentDate: DateTime.now(),
                appointmentTime: "",
                status: "",
                notes: "",
                reminderSent: false));

        if (appointment.appointmentId.isNotEmpty) {
          stdout.write("Enter New Date (YYYY-MM-DD): ");
          String? newDate = stdin.readLineSync();
          stdout.write("Enter New Time (HH:MM): ");
          String? newTime = stdin.readLineSync();
          if (newDate != null && newTime != null) {
            appointment.rescheduleAppointment(DateTime.parse(newDate), newTime);
          }
        } else {
          print("Appointment not found.");
        }
        break;

      case '6':
        print("Exiting the system...");
        return;

      default:
        print("Invalid choice! Please enter a valid option.");
    }
  }
}
