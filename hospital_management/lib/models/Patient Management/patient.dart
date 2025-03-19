import '../../database/database.dart';

class Patient {
  int id;
  String name, contactInfo, gender, address, bloodType;
  List<String> medicalHistory;
  List<String> allergies;

  static List<Patient> patients = [];

  Patient({
    required this.id,
    required this.name,
    required this.contactInfo,
    required this.gender,
    required this.address,
    required this.bloodType,
    List<String>? medicalHistory,
    List<String>? allergies,
  })  : medicalHistory = medicalHistory ?? [],
        allergies = allergies ?? [];

  static void addPatient(Patient patient) {
    patients.add(patient);
    Database.savePatients();
  }

  void clearMedicalHistory() {
    medicalHistory.clear();
    Database.savePatients();
  }

  void addMedicalRecord(String record) {
    medicalHistory.add(record);
    Database.savePatients();
  }

  void displayInfo() {
    print("ID: $id\nName: $name\nContact: $contactInfo\nGender: $gender\nAddress: $address\nBlood Type: $bloodType\nMedical History: $medicalHistory\nAllergies: $allergies");
  }

  static void getAllPatients() {
    for (var patient in patients) {
      patient.displayInfo();
      print('--------------------------');
    }
  }

  static Patient? getPatientById(int id) {
  return patients.firstWhere(
    (patient) => patient.id == id,
    orElse: () => throw Exception('Patient not found'),
  );
}


  void updatePatient({
    String? name,
    String? contactInfo,
    String? gender,
    String? address,
    String? bloodType,
  }) {
    if (name != null) this.name = name;
    if (contactInfo != null) this.contactInfo = contactInfo;
    if (gender != null) this.gender = gender;
    if (address != null) this.address = address;
    if (bloodType != null) this.bloodType = bloodType;
    Database.savePatients();
  }

  static void deletePatient(int id) {
    patients.removeWhere((patient) => patient.id == id);
    Database.savePatients();
  }

  static List<Patient> searchPatientsByName(String name) {
    return patients.where((patient) => patient.name.toLowerCase().contains(name.toLowerCase())).toList();
  }

  static List<Patient> filterPatientsByAge(int minAge, int maxAge, Map<int, int> patientAges) {
    return patients.where((patient) {
      int? age = patientAges[patient.id];
      return age != null && age >= minAge && age <= maxAge;
    }).toList();
  }

  String getContactInfo() {
    return contactInfo;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contactInfo': contactInfo,
      'gender': gender,
      'address': address,
      'bloodType': bloodType,
      'medicalHistory': medicalHistory,
      'allergies': allergies,
    };
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      contactInfo: json['contactInfo'],
      gender: json['gender'],
      address: json['address'],
      bloodType: json['bloodType'],
      medicalHistory: List<String>.from(json['medicalHistory'] ?? []),
      allergies: List<String>.from(json['allergies'] ?? []),
    );
  }
}
