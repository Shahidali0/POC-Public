// import 'package:cricket_poc/lib_exports.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class BookServiceScreen extends ConsumerWidget {
//   const BookServiceScreen({super.key, required this.serviceJson});

//   final ServiceJson serviceJson;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isLoading = ref.watch(serviceDetailsControllerPr).loading;

//     return LoadingOverlay(
//       isLoading: isLoading,
//       child: MyCupertinoSliverScaffold(
//         title: "Book Now",
//         body: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             ///About
//             ListTile(
//               contentPadding: EdgeInsets.zero,
//               horizontalTitleGap: Sizes.spaceMed,
//               title: Text(
//                 serviceJson.title!,
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                       fontSize: Sizes.fontSize18,
//                       fontWeight: FontWeight.w600,
//                     ),
//               ),
//               subtitle: Text(
//                 "${serviceJson.category} (${serviceJson.sport})",
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   color: AppColors.orange,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               trailing: Text(
//                 "\$ ${serviceJson.price}",
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: Sizes.fontSize16,
//                 ),
//               ),
//             ),

//             ///Dates
//             _DatePickerField(
//               dates: serviceJson.timeSlots!.keys.toList(),
//             ),

//             ///Time Slots
//             _TimeSlotsField(
//               timeSlotsData: serviceJson.timeSlots!.values.first,
//             ),

//             ///Duration
//             _DurationField(
//               sessionDurations: serviceJson.duration!,
//             ),

//             const SizedBox(height: Sizes.spaceHeight),

//             ///Continue Button
//             Consumer(
//               builder: (_, WidgetRef ref, __) {
//                 final state = ref.watch(serviceDetailsControllerPr);
//                 return CommonButton(
//                   onPressed: state.selectedDate.isEmpty ||
//                           state.selectedTimeSlot.isEmpty ||
//                           state.selectedSessionDuration.isEmpty
//                       ? null
//                       : () => ref
//                           .read(serviceDetailsControllerPr.notifier)
//                           .makePayment(
//                             context: context,
//                             serviceJson: serviceJson,
//                           ),
//                   text: "Continue",
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ///DatePicker Field
// class _DatePickerField extends ConsumerWidget {
//   const _DatePickerField({
//     required this.dates,
//   });

//   final List<String> dates;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedDate = ref.watch(serviceDetailsControllerPr).selectedDate;

//     return FormFiledWidget(
//       title: "Choose Date",
//       isRequired: true,
//       child: Wrap(
//         spacing: Sizes.spaceMed,
//         children: dates.map(
//           (item) {
//             bool isActive = selectedDate == item;

//             return ChoiceChip.elevated(
//               labelStyle: TextStyle(
//                 color: isActive ? AppColors.white : null,
//                 fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
//               ),
//               onSelected: (v) => ref
//                   .read(serviceDetailsControllerPr.notifier)
//                   .updateSelectedDate(item),
//               avatar: isActive
//                   ? null
//                   : const Icon(
//                       CupertinoIcons.calendar,
//                       color: AppColors.black,
//                     ),
//               label: FittedBox(child: Text(item)),
//               selected: isActive,
//             );
//           },
//         ).toList(),
//       ),
//     );
//   }
// }

// ///Time Slots
// class _TimeSlotsField extends ConsumerWidget {
//   const _TimeSlotsField({
//     required this.timeSlotsData,
//   });

//   final List<String> timeSlotsData;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedTimeSlot =
//         ref.watch(serviceDetailsControllerPr).selectedTimeSlot;

//     return FormFiledWidget(
//       title: "Choose Time",
//       isRequired: true,
//       child: Wrap(
//         spacing: Sizes.spaceMed,
//         children: timeSlotsData.map(
//           (item) {
//             bool isActive = selectedTimeSlot == item;

//             return ChoiceChip.elevated(
//               labelStyle: TextStyle(
//                 color: isActive ? AppColors.white : null,
//                 fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
//               ),
//               onSelected: (v) => ref
//                   .read(serviceDetailsControllerPr.notifier)
//                   .updateSelectedTimeSlot(item),
//               avatar: isActive
//                   ? null
//                   : const Icon(
//                       CupertinoIcons.time,
//                       color: AppColors.black,
//                     ),
//               label: FittedBox(child: Text(item)),
//               selected: isActive,
//             );
//           },
//         ).toList(),
//       ),
//     );
//   }
// }

// ///Duration
// class _DurationField extends ConsumerWidget {
//   const _DurationField({
//     required this.sessionDurations,
//   });

//   final List<String> sessionDurations;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedDuration =
//         ref.watch(serviceDetailsControllerPr).selectedSessionDuration;

//     return FormFiledWidget(
//       title: "Choose Duration",
//       isRequired: true,
//       child: Wrap(
//         spacing: Sizes.space,
//         children: sessionDurations.map(
//           (item) {
//             bool isActive = selectedDuration == item;

//             return ChoiceChip.elevated(
//               labelStyle: TextStyle(
//                 color: isActive ? AppColors.white : null,
//                 fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
//               ),
//               onSelected: (value) => ref
//                   .read(serviceDetailsControllerPr.notifier)
//                   .updateSelectedSessionDuration(item),
//               avatar: isActive
//                   ? null
//                   : const Icon(
//                       CupertinoIcons.timer,
//                       color: AppColors.black,
//                     ),
//               label: Text("$item min"),
//               selected: isActive,
//             );
//           },
//         ).toList(),
//       ),
//     );
//   }
// }
