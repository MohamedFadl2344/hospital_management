import '../../database/database.dart';

class Doctor {
  String doctorId;
  String name;
  String specialization;
  String contactInfo;
  String workSchedule;
  double consultationFee;
  String availabilityStatus;
  String operationSchedule;
  int experienceYears;
  List<double> ratings;
  String bio;

  static List<Doctor> doctorsList = [];

  Doctor({
    required this.doctorId,
    required this.name,
    required this.specialization,
    required this.contactInfo,
    required this.workSchedule,
    required this.consultationFee,
    required this.availabilityStatus,
    required this.operationSchedule,
    required this.experienceYears,
    required this.ratings,
    required this.bio,
  });

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'name': name,
      'specialization': specialization,
      'contactInfo': contactInfo,
      'workSchedule': workSchedule,
      'consultationFee': consultationFee,
      'availabilityStatus': availabilityStatus,
      'operationSchedule': operationSchedule,
      'experienceYears': experienceYears,
      'ratings': ratings,
      'bio': bio,
    };
  }

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      doctorId: json['doctorId'],
      name: json['name'],
      specialization: json['specialization'],
      contactInfo: json['contactInfo'],
      workSchedule: json['workSchedule'],
      consultationFee: json['consultationFee'],
      availabilityStatus: json['availabilityStatus'],
      operationSchedule: json['operationSchedule'],
      experienceYears: json['experienceYears'],
      ratings: List<double>.from(json['ratings'] ?? []),
      bio: json['bio'],
    );
  }

  void addDoctor() {
    doctorsList.add(this);
    Database.saveDoctors();
    print("Doctor \$name has been added successfully.");
  }

  static void removeDoctor(String doctorId) {
    doctorsList.removeWhere((doctor) => doctor.doctorId == doctorId);
    Database.saveDoctors();
    print("Doctor with ID \$doctorId has been removed.");
  }

  static void updateDoctorInfo(String doctorId, Map<String, dynamic> updatedData) {
    Doctor? doctor = doctorsList.firstWhereOrNull((d) => d.doctorId == doctorId);

    if (doctor != null) {
      updatedData.forEach((key, value) {
        switch (key) {
          case 'name':
            doctor.name = value;
            break;
          case 'specialization':
            doctor.specialization = value;
            break;
          case 'contactInfo':
            doctor.contactInfo = value;
            break;
          case 'workSchedule':
            doctor.workSchedule = value;
            break;
          case 'consultationFee':
            doctor.consultationFee = value;
            break;
          case 'availabilityStatus':
            doctor.availabilityStatus = value;
            break;
          case 'operationSchedule':
            doctor.operationSchedule = value;
            break;
          case 'experienceYears':
            doctor.experienceYears = value;
            break;
          case 'bio':
            doctor.bio = value;
            break;
        }
      });
      Database.saveDoctors();
      print("Doctor information updated successfully.");
    } else {
      print("Doctor not found.");
    }
  }

  static void viewAllDoctors() {
    if (doctorsList.isEmpty) {
      print("No doctors available.");
      return;
    }
    doctorsList.forEach((doctor) {
      print("Doctor ID: ${doctor.doctorId}, Name: ${doctor.name}, Specialization: ${doctor.specialization}");
    });
  }

  static void searchDoctorByName(String name) {
    List<Doctor> foundDoctors = doctorsList
        .where((doctor) => doctor.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
    if (foundDoctors.isEmpty) {
      print("No doctor found with the name \$name.");
    } else {
      doctorsList.forEach((doctor) {
      print("Doctor ID: ${doctor.doctorId}, Name: ${doctor.name}, Specialization: ${doctor.specialization}");
    });
    }
  }
}

extension FirstWhereOrNullExtension<E> on List<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}