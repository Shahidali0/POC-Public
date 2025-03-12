// part of 'user_registration.dart';

// ///FullName Field
// class _FullNameField extends StatelessWidget {
//   const _FullNameField({
//     required this.controller,
//   });

//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return FormFiledWidget(
//       title: "Full Name",
//       child: TextFormField(
//         controller: controller,
//         keyboardType: TextInputType.name,
//         validator: FieldValidators.instance.commonValidator,
//         autofillHints: Formatter.instance.nameAutoFillHints,
//         textCapitalization: TextCapitalization.words,
//         decoration: const InputDecoration(hintText: "Enter your full name"),
//       ),
//     );
//   }
// }

// ///Business Name Field
// class _BusinessNameField extends StatelessWidget {
//   const _BusinessNameField({
//     required this.controller,
//   });

//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return FormFiledWidget(
//       title: "Business Name",
//       child: TextFormField(
//         controller: controller,
//         keyboardType: TextInputType.name,
//         validator: FieldValidators.instance.commonValidator,
//         textCapitalization: TextCapitalization.words,
//         decoration: const InputDecoration(hintText: "Enter business name"),
//       ),
//     );
//   }
// }

// ///Email Field
// class _EmailField extends StatelessWidget {
//   const _EmailField({
//     required this.controller,
//   });

//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return FormFiledWidget(
//       title: "Email",
//       child: TextFormField(
//         controller: controller,
//         keyboardType: TextInputType.emailAddress,
//         validator: FieldValidators.instance.emailValidator,
//         autofillHints: Formatter.instance.emailAutoFillHints,
//         decoration: const InputDecoration(hintText: "Enter your email"),
//       ),
//     );
//   }
// }

// ///PhoneNumber Field
// class _PhoneNumberField extends StatelessWidget {
//   const _PhoneNumberField({
//     required this.controller,
//   });

//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return FormFiledWidget(
//       title: "Phone Number",
//       child: TextFormField(
//         controller: controller,
//         keyboardType: TextInputType.phone,
//         validator: FieldValidators.instance.commonValidator,
//         autofillHints: Formatter.instance.phoneAutofillHints,
//         decoration: const InputDecoration(hintText: "Enter your phone number"),
//       ),
//     );
//   }
// }

// ///IDType Field
// class _IDTypeField extends StatelessWidget {
//   const _IDTypeField({
//     required this.onChanged,
//     required this.selectedIdType,
//   });

//   final void Function(String?) onChanged;
//   final ValueNotifier<String?> selectedIdType;

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<String?>(
//       valueListenable: selectedIdType,
//       builder: (BuildContext context, String? value, Widget? child) {
//         return FormFiledWidget(
//           title: "ID Type",
//           child: DropdownButtonFormField<String>(
//             padding: EdgeInsets.zero,
//             menuMaxHeight: 300,
//             alignment: Alignment.centerLeft,
//             isExpanded: true,
//             value: value,
//             validator: FieldValidators.instance.commonValidator,
//             items: [
//               const DropdownMenuItem<String>(
//                 child: Text(
//                   "Select ID Type",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.blueGrey,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               ...idTypes.map((String valueItem) {
//                 return DropdownMenuItem<String>(
//                   value: valueItem,
//                   child: Text(
//                     valueItem,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       color: AppColors.blueGrey,
//                       fontSize: Sizes.defaultSize,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 );
//               }),
//             ],
//             onChanged: onChanged,
//             decoration: const InputDecoration(hintText: "Select ID Type"),
//           ),
//         );
//       },
//     );
//   }
// }

// ///Years of Experience
// class _YearsOfExpField extends StatelessWidget {
//   const _YearsOfExpField({
//     required this.controller,
//   });

//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return FormFiledWidget(
//       title: "Years of Experience",
//       child: TextFormField(
//         controller: controller,
//         keyboardType: const TextInputType.numberWithOptions(
//           signed: true,
//           decimal: true,
//         ),
//         inputFormatters: Formatter.instance.digitsInputFormatter,
//         validator: FieldValidators.instance.commonValidator,
//         decoration:
//             const InputDecoration(hintText: "Total years of experience"),
//       ),
//     );
//   }
// }

// ///Specialization Type
// class _SpecializationTypeField extends StatelessWidget {
//   const _SpecializationTypeField({
//     required this.selectedSpecialization,
//     required this.onChanged,
//   });

//   final ValueNotifier<String?> selectedSpecialization;
//   final void Function(String?) onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<String?>(
//       valueListenable: selectedSpecialization,
//       builder: (BuildContext context, String? value, Widget? child) {
//         return FormFiledWidget(
//           title: "Specialization",
//           child: DropdownButtonFormField<String>(
//             padding: EdgeInsets.zero,
//             menuMaxHeight: 300,
//             alignment: Alignment.centerLeft,
//             isExpanded: true,
//             value: value,
//             validator: FieldValidators.instance.commonValidator,
//             items: [
//               const DropdownMenuItem<String>(
//                 child: Text(
//                   "Select Specialization",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.blueGrey,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               ...specializations.map((String valueItem) {
//                 return DropdownMenuItem<String>(
//                   value: valueItem,
//                   child: Text(
//                     valueItem,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       color: AppColors.blueGrey,
//                       fontSize: Sizes.defaultSize,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 );
//               }),
//             ],
//             onChanged: onChanged,
//             decoration:
//                 const InputDecoration(hintText: "Select Specialization"),
//           ),
//         );
//       },
//     );
//   }
// }

// ///Id Number Field
// class _IdNumberField extends StatelessWidget {
//   const _IdNumberField({
//     required this.controller,
//   });

//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return FormFiledWidget(
//       title: "Id Number",
//       child: TextFormField(
//         controller: controller,
//         keyboardType: TextInputType.text,
//         validator: FieldValidators.instance.commonValidator,
//         inputFormatters: Formatter.instance.digitsInputFormatter,
//         decoration: const InputDecoration(hintText: "Enter ID number"),
//       ),
//     );
//   }
// }

// ///Tax ID / Business Registration Number Field
// class _TaxIdNumberField extends StatelessWidget {
//   const _TaxIdNumberField({
//     required this.controller,
//   });

//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return FormFiledWidget(
//       title: "Tax ID / Business Registration Number",
//       child: TextFormField(
//         controller: controller,
//         keyboardType: TextInputType.text,
//         validator: FieldValidators.instance.commonValidator,
//         decoration: const InputDecoration(
//           hintText: "Enter Tax ID / Business Registration Number",
//         ),
//       ),
//     );
//   }
// }

// ///Address Field
// class _AddressField extends StatelessWidget {
//   const _AddressField({
//     required this.controller,
//     this.titleName,
//   });

//   final TextEditingController controller;
//   final String? titleName;

//   @override
//   Widget build(BuildContext context) {
//     return FormFiledWidget(
//       title: titleName ?? "Address",
//       child: TextFormField(
//         controller: controller,
//         maxLines: 6,
//         minLines: 3,

//         ///Limits 100 characters
//         maxLength: 100,
//         keyboardType: TextInputType.streetAddress,
//         validator: FieldValidators.instance.commonValidator,
//         autofillHints: Formatter.instance.addressAutoFillHints,
//         decoration: InputDecoration(
//             hintText: "Enter your ${titleName?.toLowerCase() ?? "address"}"),
//       ),
//     );
//   }
// }
