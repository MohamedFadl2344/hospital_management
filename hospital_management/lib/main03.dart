import 'dart:io';
import 'models/Doctor Management/doctor.dart';
import 'database/database.dart';

void main() {
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
