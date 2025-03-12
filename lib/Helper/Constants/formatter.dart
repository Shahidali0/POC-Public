import 'package:flutter/services.dart';

class Formatter {
  Formatter._();
  static Formatter get instance => Formatter._();

  ///Formatters
  List<TextInputFormatter> get nameInputFormatter => [
        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
      ];
  List<TextInputFormatter> get digitsInputFormatter => [
        FilteringTextInputFormatter.allow(RegExp('[-0-9-.+  ]')),
        FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.deny(RegExp(' ')),
      ];

  List<TextInputFormatter> get phoneInputFormatters =>
      [FilteringTextInputFormatter.digitsOnly];

  ///AuttoFill Hints

  List<String> get nameAutoFillHints => [AutofillHints.name];

  List<String> get emailAutoFillHints => [AutofillHints.email];

  List<String> get passwordAutoFillHints => [AutofillHints.password];

  List<String> get firstNameAutoFillHints => [AutofillHints.givenName];

  List<String> get lastNameAutoFillHints => [AutofillHints.familyName];

  List<String> get userNameAutoFillHints => [AutofillHints.username];

  List<String> get addressAutoFillHints => [
        AutofillHints.postalAddress,
        AutofillHints.sublocality,
        AutofillHints.streetAddressLevel1,
        AutofillHints.streetAddressLine1,
        AutofillHints.addressCityAndState,
        AutofillHints.postalAddressExtendedPostalCode,
      ];

  List<String> get postalCodeAutoFillHints => [AutofillHints.postalCode];

  List<String> get countryNameAutoFillHints => [AutofillHints.countryName];

  List<String> get stateAutoFillHints => [AutofillHints.addressState];

  List<String> get cityAutoFillHints => [AutofillHints.addressCity];

  List<String> get phoneAutofillHints =>
      [AutofillHints.telephoneNumberNational];
}
