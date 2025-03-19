import 'dart:convert';
import 'dart:io';
import '../models/Patient Management/patient.dart';
import '../models/Appointment Scheduling/appointment.dart';
import '../models/Doctor Management/doctor.dart';


class Database {
  static const String patientFilePath = 'patients.json';
  static const String appointmentFilePath = 'appointments.json';
  static const String doctorFilePath = 'doctors.json';

  static void loadPatients() {
    try {
      File file = File(patientFilePath);
      if (!file.existsSync()) {
        file.createSync(recursive: true);
        file.writeAsStringSync(jsonEncode([]));
      }
      List<dynamic> data = jsonDecode(file.readAsStringSync());
      Patient.patients = data.map((p) => Patient.fromJson(p)).toList();
      print("Successfully loaded ${Patient.patients.length} patients.");
    } catch (e) {
      print("Error loading patients: $e");
      Patient.patients = [];
    }
  }

  static void savePatients() {
    try {
      List<Map<String, dynamic>> patientList = Patient.patients.map((p) => p.toJson()).toList();
      File(patientFilePath).writeAsStringSync(jsonEncode(patientList));
      print("Successfully saved ${Patient.patients.length} patients.");
    } catch (e) {
      print("Error saving patients: $e");
    }
  }

  static void saveAppointments() {
    try {
      List<Map<String, dynamic>> appointmentList = Appointment.appointments.map((a) => a.toJson()).toList();
      File(appointmentFilePath).writeAsStringSync(jsonEncode(appointmentList));
      print("Successfully saved ${Appointment.appointments.length} appointments.");
    } catch (e) {
      print("Error saving appointments: $e");
    }
  }

  static void loadAppointments() {
    try {
      File file = File(appointmentFilePath);
      if (!file.existsSync()) {
        file.createSync(recursive: true);
        file.writeAsStringSync(jsonEncode([]));
      }
      List<dynamic> data = jsonDecode(file.readAsStringSync());
      Appointment.appointments = data.map((a) => Appointment.fromJson(a)).toList();
      print("Successfully loaded ${Appointment.appointments.length} appointments.");
    } catch (e) {
      print("Error loading appointments: $e");
      Appointment.appointments = [];
    }
  }

   static void loadDoctors() {
    try {
      File file = File(doctorFilePath);
      if (!file.existsSync()) {
        file.createSync(recursive: true);
        file.writeAsStringSync(jsonEncode([]));
      }
      List<dynamic> data = jsonDecode(file.readAsStringSync());
      Doctor.doctorsList = data.map((d) => Doctor.fromJson(d)).toList();
      print("Successfully loaded \${Doctor.doctorsList.length} doctors.");
    } catch (e) {
      print("Error loading doctors: $e");
      Doctor.doctorsList = [];
    }
  }

  static void saveDoctors() {
    try {
      List<Map<String, dynamic>> doctorList = Doctor.doctorsList.map((d) => d.toJson()).toList();
      File(doctorFilePath).writeAsStringSync(jsonEncode(doctorList));
      print("Successfully saved \${Doctor.doctorsList.length} doctors.");
    } catch (e) {
      print("Error saving doctors: $e");
    }
  }
}
