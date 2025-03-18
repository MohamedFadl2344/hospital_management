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

  void addDoctor() {
    doctorsList.add(this);
    print("Doctor ${name} has been added successfully.");
  }

  static void removeDoctor(String doctorId) {
    doctorsList.removeWhere((doctor) => doctor.doctorId == doctorId);
    print("Doctor with ID $doctorId has been removed.");
  }

  static void updateDoctorInfo(String doctorId, Map<String, dynamic> updatedData) {
    Doctor? doctor = doctorsList.firstWhere((d) => d.doctorId == doctorId, orElse: () => Doctor(
      doctorId: '',
      name: '',
      specialization: '',
      contactInfo: '',
      workSchedule: '',
      consultationFee: 0.0,
      availabilityStatus: '',
      operationSchedule: '',
      experienceYears: 0,
      ratings: [],
      bio: '',
    ));

    if (doctor.doctorId.isNotEmpty) {
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
    for (var doctor in doctorsList) {
      print("Doctor ID: ${doctor.doctorId}, Name: ${doctor.name}, Specialization: ${doctor.specialization}");
    }
  }

  static void searchDoctorByName(String name) {
    List<Doctor> foundDoctors = doctorsList.where((doctor) => doctor.name.toLowerCase().contains(name.toLowerCase())).toList();
    if (foundDoctors.isEmpty) {
      print("No doctor found with the name $name.");
    } else {
      for (var doctor in foundDoctors) {
        print("Doctor ID: ${doctor.doctorId}, Name: ${doctor.name}, Specialization: ${doctor.specialization}");
      }
    }
  }
}
