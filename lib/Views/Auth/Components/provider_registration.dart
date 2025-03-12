part of 'user_registration.dart';

class ProviderRegistrationPage extends ConsumerStatefulWidget {
  const ProviderRegistrationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProviderRegistrationState();
}

class _ProviderRegistrationState
    extends ConsumerState<ProviderRegistrationPage> {
  late TextEditingController _fullNameController;
  late TextEditingController _businessNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _yearsOfExpController;
  late TextEditingController _idNumberController;
  late TextEditingController _taxIdController;

  ValueNotifier<String?> _selectedIdType = ValueNotifier(null);
  ValueNotifier<String?> _selectedSpecialization = ValueNotifier(null);
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _fullNameController = TextEditingController();
    _businessNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _yearsOfExpController = TextEditingController();
    _idNumberController = TextEditingController();
    _taxIdController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _businessNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _yearsOfExpController.dispose();
    _idNumberController.dispose();
    _taxIdController.dispose();

    super.dispose();
  }

  ///OnChanged IDtype
  void _onChangedIdType(String? value) {
    if (value == null) return;

    _selectedIdType = ValueNotifier(value);
    debugPrint("_selectedIdType:${_selectedIdType.value}");
  }

  ///OnChanged Specialization
  void _onChangedSpecialization(String? value) {
    if (value == null) return;

    _selectedSpecialization = ValueNotifier(value);
    debugPrint("_selectedSpecialization:${_selectedSpecialization.value}");
  }

  ///OnTap Register as Provider
  void _onTapRegisterAsProvider({required BuildContext context}) {
    bool validated = validateForm(_formKey);

    final providerData = ProviderRegistrationDto(
      fullName: _fullNameController.text.trim(),
      businessName: _businessNameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      yearsOfExperience: _yearsOfExpController.text.trim(),
      specialization: _selectedSpecialization.value ?? "",
      idType: _selectedIdType.value ?? "",
      idNumber: _idNumberController.text.trim(),
      taxIdNumber: _taxIdController.text.trim(),
      businessAddress: _addressController.text.trim(),
      isValidated: validated,
    );

    return ref.read(authControllerPr.notifier).onTapRegisterAsProvider(
          context: context,
          providerData: providerData,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Service Provider Registration",
              style: TextStyle(
                fontSize: Sizes.fontSize20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Text(
              "Register to offer your cricket services and equipment",
              style: TextStyle(
                fontSize: Sizes.defaultSize,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: Sizes.spaceSmall),
            _FullNameField(controller: _fullNameController),
            _BusinessNameField(controller: _businessNameController),
            _EmailField(controller: _emailController),
            _PhoneNumberField(controller: _phoneController),
            _YearsOfExpField(controller: _yearsOfExpController),
            _SpecializationTypeField(
              selectedSpecialization: _selectedSpecialization,
              onChanged: _onChangedSpecialization,
            ),
            _IDTypeField(
              onChanged: _onChangedIdType,
              selectedIdType: _selectedIdType,
            ),
            _IdNumberField(controller: _idNumberController),
            _TaxIdNumberField(controller: _taxIdController),
            _AddressField(
              controller: _addressController,
              titleName: "Business Address",
            ),
            const SizedBox(height: Sizes.spaceHeight),

            ///Register Button
            CommonButton(
              onPressed: () => _onTapRegisterAsProvider(context: context),
              text: "Register as Provider",
            ),

            const SizedBox(height: Sizes.spaceHeight),
            const HaveAnAccountWidget(authType: AuthType.signup),
          ],
        ),
      ),
    );
  }
}
