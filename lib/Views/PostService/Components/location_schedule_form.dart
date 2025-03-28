import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocationScheduleForm extends ConsumerWidget {
  const LocationScheduleForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(postServiceControllerPr.notifier);

    return Form(
      key: controller.locationScheduleFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Location & Schedule",
            style: TextStyle(
              fontSize: Sizes.fontSize18,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const Text(
            "Set where and when your service is available",
          ),
          const SizedBox(height: Sizes.spaceSmall),

          ///Location
          _LocationField(controller: controller.locationController),

          ///Available Dates
          _AvailableDates(selectedDays: controller.selectedDays),
          _ValidationErrorMessage(listenable: controller.datesValidation),

          ///Available Time Slots
          _AvailableTimeSlots(
            selectedTimeSlots: controller.selectedTimeSlotsListenable,
            onSelectTimeSlot: (value) =>
                controller.updateSelectedTimeSlots(value),
          ),
          _ValidationErrorMessage(listenable: controller.timeSlotValidation),

          ///Session Duration
          _SessionDurationField(
            selectedSessionDuration:
                controller.selectedSessionDurationListenable,
            onChanged: (value) =>
                controller.updateSelectedSessionDuration(value),
          ),
          _ValidationErrorMessage(
            listenable: controller.sessionDurationValidation,
          ),

          const SizedBox(height: Sizes.spaceHeight),
        ],
      ),
    );
  }
}

///Location Field
class _LocationField extends StatelessWidget {
  const _LocationField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FormFiledWidget(
      title: "Location",
      isRequired: true,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.name,
        validator: FieldValidators.instance.commonValidator,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
          hintText: "e.g., Melbourne Cricket Ground",
        ),
      ),
    );
  }
}

///Available Dates
class _AvailableDates extends StatelessWidget {
  const _AvailableDates({
    required this.selectedDays,
  });

  final Set<DateTime> selectedDays;

  @override
  Widget build(BuildContext context) {
    DateTime focusedDay = DateTime.now();

    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return FormFiledWidget(
          title: "Available Dates",
          isRequired: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: Sizes.spaceMed),

              ///DatePicker--Multi
              Card(
                margin: EdgeInsets.zero,
                child: TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  focusedDay: focusedDay,
                  calendarFormat: CalendarFormat.month,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  headerStyle: headerStyle,
                  daysOfWeekStyle: daysOfWeekStyle,
                  calendarStyle: calendarStyle,
                  selectedDayPredicate: (day) => selectedDays.contains(day),
                  onDaySelected:
                      (DateTime selectedDayValue, DateTime focusedDayValue) {
                    focusedDay = focusedDayValue;
                    // Update values in a Set
                    if (selectedDays.contains(selectedDayValue)) {
                      selectedDays.remove(selectedDayValue);
                    } else {
                      selectedDays.add(selectedDayValue);
                    }

                    setState(() {});
                  },
                  onPageChanged: (DateTime date) => focusedDay = date,
                ),
              ),

              ///Selected Days
              CupertinoScrollbar(
                scrollbarOrientation: ScrollbarOrientation.bottom,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    bottom: Sizes.spaceMed,
                    top: Sizes.spaceMed,
                  ),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: selectedDays
                        .map(
                          (day) => Padding(
                            padding:
                                const EdgeInsets.only(right: Sizes.spaceMed),
                            child: Chip(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Sizes.borderRadius),
                                side: const BorderSide(color: AppColors.black),
                              ),
                              label: Text(
                                Utils.instance.formatDateToString(day),
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///HEADER STYLE
  HeaderStyle get headerStyle => const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        decoration: BoxDecoration(
          color: AppColors.blueGrey,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Sizes.borderRadius),
          ),
        ),
        leftChevronPadding: EdgeInsets.zero,
        rightChevronPadding: EdgeInsets.zero,
        headerMargin: EdgeInsets.only(bottom: Sizes.space),
        leftChevronIcon: Icon(
          CupertinoIcons.chevron_left,
          color: AppColors.white,
        ),
        rightChevronIcon: Icon(
          CupertinoIcons.chevron_right,
          color: AppColors.white,
        ),
        titleTextStyle: TextStyle(
          fontSize: Sizes.fontSize16,
          color: AppColors.white,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w800,
        ),
      );

  ///DAYS OF WEEK STYLE
  DaysOfWeekStyle get daysOfWeekStyle => const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: AppColors.black),
        weekendStyle: TextStyle(
          color: AppColors.orange,
          fontWeight: FontWeight.w600,
        ),
      );

  ///CALENDAR STYLE
  CalendarStyle get calendarStyle => const CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: AppColors.black,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Sizes.fontSize16,
          color: AppColors.white,
        ),
        todayDecoration: BoxDecoration(
          color: AppColors.grey,
          shape: BoxShape.circle,
        ),
        holidayTextStyle: TextStyle(color: AppColors.green),
        weekendTextStyle: TextStyle(
          color: AppColors.orange,
          fontWeight: FontWeight.w600,
        ),
      );
}

///Available Time Slots
class _AvailableTimeSlots extends StatelessWidget {
  const _AvailableTimeSlots({
    required this.selectedTimeSlots,
    required this.onSelectTimeSlot,
  });

  final ValueListenable<List<String>> selectedTimeSlots;
  final ValueChanged onSelectTimeSlot;

  @override
  Widget build(BuildContext context) {
    final width = Sizes.screenWidth(context);

    return FormFiledWidget(
      title: "Available Time Slots",
      isRequired: true,
      child: SizedBox(
        width: width,
        height: 160,
        child: ValueListenableBuilder<List<String>>(
          valueListenable: selectedTimeSlots,
          builder: (BuildContext context, List<String> value, Widget? child) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: Sizes.spaceMed),
              primary: false,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                // mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: timeSlotsData.length,
              itemBuilder: (BuildContext context, int index) {
                bool isActive = value.contains(timeSlotsData[index]);

                return ChoiceChip(
                  labelPadding: const EdgeInsets.all(Sizes.spaceSmall),
                  labelStyle: TextStyle(
                    color: isActive ? AppColors.white : null,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
                  ),
                  onSelected: (data) {
                    onSelectTimeSlot(timeSlotsData[index]);
                  },
                  avatar: isActive
                      ? null
                      : const Icon(
                          CupertinoIcons.timer,
                          color: AppColors.black,
                        ),
                  label: Text(timeSlotsData[index]),
                  selected: isActive,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

///Session Duration
class _SessionDurationField extends StatelessWidget {
  const _SessionDurationField({
    required this.selectedSessionDuration,
    required this.onChanged,
  });

  final ValueNotifier<List<String>> selectedSessionDuration;
  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return FormFiledWidget(
      title: "Session Duration",
      isRequired: true,
      child: ValueListenableBuilder<List<String>>(
        valueListenable: selectedSessionDuration,
        builder: (BuildContext context, List<String> value, Widget? child) {
          return Padding(
            padding: const EdgeInsets.only(top: Sizes.spaceMed),
            child: Wrap(
              spacing: Sizes.spaceMed,
              alignment: WrapAlignment.spaceAround,
              children: List.generate(
                durationData.length,
                (index) {
                  bool isActive = value.contains(durationData[index]);

                  return ChoiceChip(
                    labelPadding: const EdgeInsets.symmetric(
                      vertical: Sizes.spaceSmall,
                      horizontal: Sizes.spaceHeight,
                    ),
                    labelStyle: TextStyle(
                      color: isActive ? AppColors.white : null,
                      fontWeight:
                          isActive ? FontWeight.w700 : FontWeight.normal,
                    ),
                    onSelected: (data) {
                      onChanged(durationData[index]);
                    },
                    avatar: isActive
                        ? null
                        : const Icon(
                            CupertinoIcons.timer,
                            color: AppColors.black,
                          ),
                    label: Text(durationData[index]),
                    selected: isActive,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  //  return ValueListenableBuilder<String?>(
  //   valueListenable: selectedSessionDuration,
  //   builder: (BuildContext context, String? value, Widget? child) {
  // return FormFiledWidget(
  //       title: "Session Duration",
  //       isRequired: true,
  //       child: DropdownButtonFormField<String>(
  //         padding: EdgeInsets.zero,
  //         alignment: Alignment.centerLeft,
  //         isExpanded: true,
  //         value: value,
  //         validator: FieldValidators.instance.commonValidator,
  //         items: duration.map((String valueItem) {
  //           return DropdownMenuItem<String>(
  //             value: valueItem,
  //             child: Text(
  //               valueItem,
  //               overflow: TextOverflow.ellipsis,
  //               style: const TextStyle(
  //                 color: AppColors.blueGrey,
  //                 fontWeight: FontWeight.w800,
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //         onChanged: (value) {
  //           if (value != null) onChanged(value);
  //         },
  //         decoration: const InputDecoration(),
  //       ),
  //     );
  //  },
  // );
}

///Validation Error Message
class _ValidationErrorMessage extends StatelessWidget {
  const _ValidationErrorMessage({required this.listenable});

  final ValueNotifier<String> listenable;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: listenable,
      builder: (BuildContext context, String value, Widget? child) {
        if (value.isEmpty) return const SizedBox.shrink();

        return ValidationErrorText(
          padding: EdgeInsets.zero,
          text: value,
        );
      },
    );
  }
}
