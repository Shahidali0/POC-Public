// import 'package:cricket_poc/lib_exports.dart';
// import 'package:flutter/material.dart';

// part 'formfields.dart';
// part 'provider_registration.dart';

// ///This Screen show user registration form
// class UserRegistrationPage extends ConsumerStatefulWidget {
//   const UserRegistrationPage({super.key});

//   @override
//   ConsumerState<UserRegistrationPage> createState() => _UserRegistrationState();
// }

// class _UserRegistrationState extends ConsumerState<UserRegistrationPage> {
//   late TextEditingController _fullNameController;
//   late TextEditingController _emailController;
//   late TextEditingController _phoneController;
//   late TextEditingController _addressController;
//   late TextEditingController _idNumberController;
//   ValueNotifier<String?> _selectedIdType = ValueNotifier(null);
//   late GlobalKey<FormState> _formKey;

//   @override
//   void initState() {
//     _fullNameController = TextEditingController();
//     _emailController = TextEditingController();
//     _phoneController = TextEditingController();
//     _addressController = TextEditingController();
//     _idNumberController = TextEditingController();
//     _formKey = GlobalKey<FormState>();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _addressController.dispose();
//     _idNumberController.dispose();

//     super.dispose();
//   }

//   ///OnChanged IDtype
//   void _onChangedIdType(String? value) {
//     if (value == null) return;

//     _selectedIdType = ValueNotifier(value);
//   }

//   ///OnTap Register as User
//   void _onTapRegisterAsUser({required BuildContext context}) {
//     bool validated = validateForm(_formKey);

//     final userData = UserRegistrationDto(
//       fullName: _fullNameController.text.trim(),
//       email: _emailController.text.trim(),
//       phoneNumber: _phoneController.text.trim(),
//       idType: _selectedIdType.value ?? "",
//       idNumber: _idNumberController.text.trim(),
//       address: _addressController.text.trim(),
//       isValidated: validated,
//     );

//     return ref.read(authControllerPr.notifier).onTapRegisterAsUser(
//           context: context,
//           userData: userData,
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "User Registration",
//               style: TextStyle(
//                 fontSize: Sizes.fontSize20,
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//             const Text(
//               "Register to book cricket services and equipment",
//               style: TextStyle(
//                 fontSize: Sizes.defaultSize,
//                 fontWeight: FontWeight.normal,
//               ),
//             ),
//             const SizedBox(height: Sizes.spaceSmall),
//             _FullNameField(controller: _fullNameController),
//             _EmailField(controller: _emailController),
//             _PhoneNumberField(controller: _phoneController),
//             _IDTypeField(
//               onChanged: _onChangedIdType,
//               selectedIdType: _selectedIdType,
//             ),
//             _IdNumberField(controller: _idNumberController),
//             _AddressField(controller: _addressController),
//             const SizedBox(height: Sizes.spaceHeight),

//             ///Register Button
//             CommonButton(
//               onPressed: () => _onTapRegisterAsUser(context: context),
//               text: "Register as User",
//             ),
//             const SizedBox(height: Sizes.spaceHeight),
//             const HaveAnAccountWidget(authType: AuthType.signup),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ///FullName Field
// // class _FullNameField extends StatelessWidget {
// //   const _FullNameField({
// //     required this.controller,
// //   });

// //   final TextEditingController controller;

// //   @override
// //   Widget build(BuildContext context) {
// //     return FormFiledWidget(
// //       title: "Full Name",
// //       child: TextFormField(
// //         controller: controller,
// //         keyboardType: TextInputType.name,
// //         validator: FieldValidators.instance.commonValidator,
// //         autofillHints: Formatter.instance.nameAutoFillHints,
// //         textCapitalization: TextCapitalization.words,
// //         decoration: const InputDecoration(hintText: "Enter your full name"),
// //       ),
// //     );
// //   }
// // }

// // ///Email Field
// // class _EmailField extends StatelessWidget {
// //   const _EmailField({
// //     required this.controller,
// //   });

// //   final TextEditingController controller;

// //   @override
// //   Widget build(BuildContext context) {
// //     return FormFiledWidget(
// //       title: "Email",
// //       child: TextFormField(
// //         controller: controller,
// //         keyboardType: TextInputType.emailAddress,
// //         validator: FieldValidators.instance.emailValidator,
// //         autofillHints: Formatter.instance.emailAutoFillHints,
// //         decoration: const InputDecoration(hintText: "Enter your email"),
// //       ),
// //     );
// //   }
// // }

// // ///PhoneNumber Field
// // class _PhoneNumberField extends StatelessWidget {
// //   const _PhoneNumberField({
// //     required this.controller,
// //   });

// //   final TextEditingController controller;

// //   @override
// //   Widget build(BuildContext context) {
// //     return FormFiledWidget(
// //       title: "Phone Number",
// //       child: TextFormField(
// //         controller: controller,
// //         keyboardType: TextInputType.phone,
// //         validator: FieldValidators.instance.commonValidator,
// //         autofillHints: Formatter.instance.phoneAutofillHints,
// //         decoration: const InputDecoration(hintText: "Enter your phone number"),
// //       ),
// //     );
// //   }
// // }

// // ///IDType Field
// // class _IDTypeField extends StatelessWidget {
// //   const _IDTypeField({
// //     required this.onChanged,
// //     required this.selectedIdType,
// //   });

// //   final void Function(String?) onChanged;
// //   final ValueNotifier<String?> selectedIdType;

// //   @override
// //   Widget build(BuildContext context) {
// //     return ValueListenableBuilder<String?>(
// //       valueListenable: selectedIdType,
// //       builder: (BuildContext context, String? value, Widget? child) {
// //         return FormFiledWidget(
// //           title: "ID Type",
// //           child: DropdownButtonFormField<String>(
// //             padding: EdgeInsets.zero,
// //             menuMaxHeight: 300,
// //             alignment: Alignment.centerLeft,
// //             isExpanded: true,
// //             value: value,
// //             validator: FieldValidators.instance.commonValidator,
// //             items: [
// //               const DropdownMenuItem<String>(
// //                 child: Text(
// //                   "Select ID Type",
// //                   style: TextStyle(
// //                     fontWeight: FontWeight.w500,
// //                     color: AppColors.blueGrey,
// //                   ),
// //                   overflow: TextOverflow.ellipsis,
// //                 ),
// //               ),
// //               ...idTypes.map((String valueItem) {
// //                 return DropdownMenuItem<String>(
// //                   value: valueItem,
// //                   child: Text(
// //                     valueItem,
// //                     overflow: TextOverflow.ellipsis,
// //                     style: const TextStyle(
// //                       color: AppColors.blueGrey,
// //                       fontSize: Sizes.fontSize16,
// //                       fontWeight: FontWeight.w800,
// //                     ),
// //                   ),
// //                 );
// //               }),
// //             ],
// //             onChanged: onChanged,
// //             decoration: const InputDecoration(hintText: "Select ID Type"),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// // ///Id Number Field
// // class _IdNumberField extends StatelessWidget {
// //   const _IdNumberField({
// //     required this.controller,
// //   });

// //   final TextEditingController controller;

// //   @override
// //   Widget build(BuildContext context) {
// //     return FormFiledWidget(
// //       title: "Id Number",
// //       child: TextFormField(
// //         controller: controller,
// //         keyboardType: TextInputType.text,
// //         validator: FieldValidators.instance.commonValidator,
// //         autofillHints: Formatter.instance.phoneAutofillHints,
// //         decoration: const InputDecoration(hintText: "Enter ID number"),
// //       ),
// //     );
// //   }
// // }

// // ///Address Field
// // class _AddressField extends StatelessWidget {
// //   const _AddressField({
// //     required this.controller,
// //   });

// //   final TextEditingController controller;

// //   @override
// //   Widget build(BuildContext context) {
// //     return FormFiledWidget(
// //       title: "Address",
// //       child: TextFormField(
// //         controller: controller,
// //         maxLines: 6,
// //         minLines: 3,

// //         ///Limits 100 characters
// //         maxLength: 100,
// //         keyboardType: TextInputType.streetAddress,
// //         validator: FieldValidators.instance.commonValidator,
// //         autofillHints: Formatter.instance.addressAutoFillHints,
// //         decoration: const InputDecoration(hintText: "Enter your address"),
// //       ),
// //     );
// //   }
// // }
