import 'dart:io';
import 'database/database.dart';
import 'models/Patient Management/patient.dart';
import 'models/Appointment Scheduling/appointment.dart';
import 'models/Doctor Management/doctor.dart';

void patientManagement() {
  Database.loadPatients();
  while (true) {
    print("\n=== Patient Management System ===");
    print("1. Add New Patient");
    print("2. Display All Patients");
    print("3. Search Patient by Name");
    print("4. Update Patient");
    print("5. Delete Patient");
    print("6. Back to Main Menu");
    stdout.write("Choose an option: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addNewPatient();
        break;
      case '2':
        Patient.getAllPatients();
        break;
      case '3':
        searchPatientByName();
        break;
      case '4':
        updatePatient();
        break;
      case '5':
        deletePatient();
        break;
      case '6':
        return;
      default:
        print("Invalid choice! Try again.");
    }
  }
 
}

void addNewPatient() {
  stdout.write("Enter Patient ID: ");
  int id = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
  if (id == -1) {
    print("Invalid ID.");
    return;
  }

  stdout.write("Enter Name: ");
  String? name = stdin.readLineSync();
  stdout.write("Enter Contact Info: ");
  String? contactInfo = stdin.readLineSync();
  stdout.write("Enter Gender: ");
  String? gender = stdin.readLineSync();
  stdout.write("Enter Address: ");
  String? address = stdin.readLineSync();
  stdout.write("Enter Blood Type: ");
  String? bloodType = stdin.readLineSync();

  if ([name, contactInfo, gender, address, bloodType].any((element) => element == null || element.isEmpty)) {
    print("Invalid input. All fields are required.");
    return;
  }

  Patient patient = Patient(
  id: id,
  name: name ?? "", 
  contactInfo: contactInfo ?? "", 
  gender: gender ?? "", 
  address: address ?? "", 
  bloodType: bloodType ?? "", 
  medicalHistory: [],
  allergies: [],
);

  Patient.patients.add(patient);
  Database.savePatients();
  print("Patient added successfully!");
}

void searchPatientByName() {
  stdout.write("Enter name to search: ");
  String name = stdin.readLineSync() ?? '';
  List<Patient> results = Patient.searchPatientsByName(name);
  if (results.isEmpty) {
    print("No patient found with that name.");
  } else {
    print("Found ${results.length} patient(s):");
    for (var patient in results) {
      patient.displayInfo();
      print('--------------------------');
    }
  }
}

void updatePatient() {
  stdout.write("Enter Patient ID to update: ");
  int id = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
  if (id == -1) {
    print("Invalid ID.");
    return;
  }

  Patient? patient = Patient.getPatientById(id);
  if (patient == null) {
    print("Patient not found.");
    return;
  }

  stdout.write("Enter New Name (leave blank to skip): ");
  String? name = stdin.readLineSync();
  stdout.write("Enter New Contact Info (leave blank to skip): ");
  String? contactInfo = stdin.readLineSync();
  stdout.write("Enter New Gender (leave blank to skip): ");
  String? gender = stdin.readLineSync();
  stdout.write("Enter New Address (leave blank to skip): ");
  String? address = stdin.readLineSync();
  stdout.write("Enter New Blood Type (leave blank to skip): ");
  String? bloodType = stdin.readLineSync();

  patient.updatePatient(
    name: name?.isNotEmpty == true ? name : null,
    contactInfo: contactInfo?.isNotEmpty == true ? contactInfo : null,
    gender: gender?.isNotEmpty == true ? gender : null,
    address: address?.isNotEmpty == true ? address : null,
    bloodType: bloodType?.isNotEmpty == true ? bloodType : null,
  );

  Database.savePatients();
  print("Patient updated successfully!");
}

void deletePatient() {
  stdout.write("Enter Patient ID to delete: ");
  int id = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
  if (id == -1) {
    print("Invalid ID.");
    return;
  }
  Patient.deletePatient(id);
  print("Patient deleted if exists.");
}

void appointmentScheduling() {
  Database.loadAppointments();
  while (true) {
    print("\n========== Appointment Scheduling System ==========");
    print("1. Schedule Appointment");
    print("2. Cancel Appointment");
    print("3. Update Appointment");
    print("4. Back to Main Menu");
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


void doctorManagement() {
  Database.loadDoctors();
  while (true) {
    print("\n==========================================");
    print("Doctor Management System");
    print("1. Add New Doctor");
    print("2. View All Doctors");
    print("3. Search Doctor by Name");
    print("4. Update Doctor");
    print("5. Delete Doctor");
    print("6. Exit");
    print("==========================================");

    stdout.write("Enter your choice: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write("Enter Doctor ID: ");
        String doctorId = stdin.readLineSync()!;

        stdout.write("Enter Doctor Name: ");
        String name = stdin.readLineSync()!;

        stdout.write("Enter Specialization: ");
        String specialization = stdin.readLineSync()!;

        stdout.write("Enter Contact Info: ");
        String contactInfo = stdin.readLineSync()!;

        stdout.write("Enter Work Schedule: ");
        String workSchedule = stdin.readLineSync()!;

        stdout.write("Enter Consultation Fee: ");
        double consultationFee = double.parse(stdin.readLineSync()!);

        stdout.write("Enter Availability Status: ");
        String availabilityStatus = stdin.readLineSync()!;

        stdout.write("Enter Operation Schedule: ");
        String operationSchedule = stdin.readLineSync()!;

        stdout.write("Enter Experience Years: ");
        int experienceYears = int.parse(stdin.readLineSync()!);

        stdout.write("Enter Doctor Bio: ");
        String bio = stdin.readLineSync()!;

        Doctor newDoctor = Doctor(
          doctorId: doctorId,
          name: name,
          specialization: specialization,
          contactInfo: contactInfo,
          workSchedule: workSchedule,
          consultationFee: consultationFee,
          availabilityStatus: availabilityStatus,
          operationSchedule: operationSchedule,
          experienceYears: experienceYears,
          ratings: [],
          bio: bio,
        );

        newDoctor.addDoctor();
        Database.saveDoctors();
        break;

      case '2':
        Doctor.viewAllDoctors();
        break;

      case '3':
        stdout.write("Enter Doctor Name to Search: ");
        String searchName = stdin.readLineSync()!;
        Doctor.searchDoctorByName(searchName);
        break;

      case '4':
        stdout.write("Enter Doctor ID to Update: ");
        String doctorIdToUpdate = stdin.readLineSync()!;

        Map<String, dynamic> updatedData = {};

        stdout.write("Enter New Name (leave empty to skip): ");
        String newName = stdin.readLineSync()!;
        if (newName.isNotEmpty) updatedData['name'] = newName;

        stdout.write("Enter New Specialization (leave empty to skip): ");
        String newSpecialization = stdin.readLineSync()!;
        if (newSpecialization.isNotEmpty) updatedData['specialization'] = newSpecialization;

        stdout.write("Enter New Contact Info (leave empty to skip): ");
        String newContactInfo = stdin.readLineSync()!;
        if (newContactInfo.isNotEmpty) updatedData['contactInfo'] = newContactInfo;

        Doctor.updateDoctorInfo(doctorIdToUpdate, updatedData);
        Database.saveDoctors();
        break;

      case '5':
        stdout.write("Enter Doctor ID to Delete: ");
        String doctorIdToDelete = stdin.readLineSync()!;
        Doctor.removeDoctor(doctorIdToDelete);
        Database.saveDoctors();
        break;

      case '6':
        print("Exiting the system...");
        exit(0);

      default:
        print("Invalid choice, please enter a valid option.");
    }
  }
}

void main() {
  while (true) {
    print("\n====== Hospital Management System ======");
    print("1. Patient Management");
    print("2. Appointment Scheduling");
    print("3. Doctor Management");
    print("4. Exit");
    stdout.write("Choose an option: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        patientManagement();
        break;
      case '2':
        appointmentScheduling();
        break;
      case '3':
        doctorManagement();
        break;
      case '4':
        print("Exiting the system...");
        return;
      default:
        print("Invalid choice! Try again.");
    }
  }
}
