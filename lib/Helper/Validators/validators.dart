class FieldValidators {
  FieldValidators._();

  static FieldValidators get instance => FieldValidators._();

  String requiredText = "Please provide the necessary details";

  String? get strongPasswordText => 'Required Strong Password';

  String? get passwordIncorrectFormat =>
      'Password must be at least 8 characters long, one uppercase, one lowercase, one number & one special character';

  String? get passwordMisMatchText => 'Password does not match';

  ///Common Validator --- Null value check
  String? commonValidator(String? value) {
    if (value == null || value.isEmpty) return requiredText;
    return null;
  }

  //  String? phoneNumberValidator(String? value) {
  //   if (value!.isEmpty) {
  //     return requiredText;
  //   } else if (value.length < 10 || value.length > 10) {
  //     return "Enter valid phone number";
  //   }
  //   return null;
  // }

  ///Password Validator
  String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return requiredText;
    } else if (value.length < 3) {
      return strongPasswordText;
    } else if (!value.contains(
      RegExp(
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$'),
      // RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$'),
    )) {
      return passwordIncorrectFormat;
    }

    return null;
  }

  ///Email Validator
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return requiredText;
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value)) {
      return "Enter valid Email Id";
    }
    return null;
  }
}
