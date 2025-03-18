class Patient {
  int? id;
  String? name, contactInfo, gender, address, bloodType;
  List<String>? medicalHistory;
  List<String>? allergies;

  // List to store all patients
  static List<Patient> patients = [];

  // Constructor to create a new patient
  Patient({
    this.id,
    this.name,
    this.contactInfo,
    this.gender,
    this.address,
    this.bloodType,
    this.medicalHistory,
    this.allergies,
  });

  // Add patient details
  void addPatient({
    required int id,
    required String name,
    required String contactInfo,
    required String gender,
    required String address,
    required String bloodType,
  }) {
    this.id = id;
    this.name = name;
    this.contactInfo = contactInfo;
    this.gender = gender;
    this.address = address;
    this.bloodType = bloodType;
    this.medicalHistory = [];
    this.allergies = [];
    patients.add(this); // Add to the static list
  }

  // Remove only medical history
  void removeHistory() {
    this.medicalHistory = [];
  }

  // Add to medical history
  void addMedicalRecord(String record) {
    medicalHistory ??= [];
    medicalHistory!.add(record);
  }

  // Display patient info
  void displayInfo() {
    print("ID: $id");
    print("Name: $name");
    print("Contact: $contactInfo");
    print("Gender: $gender");
    print("Address: $address");
    print("Blood Type: $bloodType");
    print("Medical History: $medicalHistory");
    print("Allergies: $allergies");
  }

  // Get all patients
  static void getAllPatients() {
    for (var patient in patients) {
      patient.displayInfo();
      print('--------------------------');
    }
  }

  // Get patient by ID
  static Patient? getPatientById(int id) {
    return patients.firstWhere((patient) => patient.id == id, orElse: () => Patient());
  }

  // Update patient info
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
  }

  // Delete patient
  static void deletePatient(int id) {
    patients.removeWhere((patient) => patient.id == id);
  }

  // Search patients by name
  static List<Patient> searchPatientsByName(String name) {
    return patients.where((patient) => patient.name!.toLowerCase().contains(name.toLowerCase())).toList();
  }

  // Filter patients by age (Assuming age is calculated elsewhere)
  static List<Patient> filterPatientsByAge(int minAge, int maxAge, Map<int, int> patientAges) {
    return patients.where((patient) {
      int? age = patientAges[patient.id];
      return age != null && age >= minAge && age <= maxAge;
    }).toList();
  }

  // Get contact info
  String? getContactInfo() {
    return contactInfo;
  }
}
