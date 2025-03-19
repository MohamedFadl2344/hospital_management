import 'dart:io';
import 'database/database.dart';
import 'models/Patient Management/patient.dart';

void main() {
  Database.loadPatients();
  while (true) {
    print("\n=== Patient Management System ===");
    print("1. Add New Patient");
    print("2. Display All Patients");
    print("3. Search Patient by Name");
    print("4. Update Patient");
    print("5. Delete Patient");
    print("6. Exit");
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
        print("Exiting... ");
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