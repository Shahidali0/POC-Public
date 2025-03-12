///Registered as user
class UserRegistrationDto {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String idType;
  final String idNumber;
  final String address;
  final bool isValidated;

  UserRegistrationDto({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.idType,
    required this.idNumber,
    required this.address,
    required this.isValidated,
  });
}

///Registered as provider
class ProviderRegistrationDto {
  final String fullName;
  final String businessName;
  final String email;
  final String phoneNumber;
  final String yearsOfExperience;
  final String specialization;
  final String idType;
  final String idNumber;
  final String taxIdNumber;
  final String businessAddress;
  final bool isValidated;

  ProviderRegistrationDto({
    required this.fullName,
    required this.businessName,
    required this.email,
    required this.phoneNumber,
    required this.yearsOfExperience,
    required this.specialization,
    required this.idType,
    required this.idNumber,
    required this.taxIdNumber,
    required this.businessAddress,
    required this.isValidated,
  });
}
