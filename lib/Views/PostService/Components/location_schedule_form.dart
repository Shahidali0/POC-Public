import 'dart:collection';

import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocationScheduleForm extends ConsumerStatefulWidget {
  const LocationScheduleForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LocationScheduleFormState();
}

class _LocationScheduleFormState extends ConsumerState<LocationScheduleForm> {
  late TextEditingController _locationController;

  late ValueNotifier<String?> _selectedTimeSlotsListenable;
  late ValueNotifier<String> _selectedSessionDurationListenable;

  ///For Multi-Dates-Picker
  // Using a `LinkedHashSet` is recommended due to equality comparison override
  late Set<DateTime> _selectedDays;

  @override
  void initState() {
    _locationController = TextEditingController();
    _selectedTimeSlotsListenable = ValueNotifier(null);
    _selectedSessionDurationListenable = ValueNotifier(duration[0]);
    _selectedDays = LinkedHashSet<DateTime>(
      equals: isSameDay,
      hashCode: Utils.instance.getHashCode,
    );
    super.initState();
  }

  @override
  void dispose() {
    _locationController.dispose();
    _selectedTimeSlotsListenable.dispose();

    super.dispose();
  }

  ///Update Selected TimeSlot Value
  void _updateSelectedTimeSlots(String value) =>
      _selectedTimeSlotsListenable.value = value;

  ///Update Selected Session Duration Value
  void _updateSelectedSessionDuration(String value) {
    _selectedSessionDurationListenable.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ref.read(postServiceControllerPr.notifier).locationScheduleFormKey,
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
          _LocationField(controller: _locationController),

          ///Available Dates
          _AvailableDates(selectedDays: _selectedDays),

          ///Available Time Slots
          _AvailableTimeSlots(
            selectedTimeSlots: _selectedTimeSlotsListenable,
            onSelectTimeSlot: _updateSelectedTimeSlots,
          ),

          ///Session Duration
          _SessionDurationField(
            selectedSessionDuration: _selectedSessionDurationListenable,
            onChanged: _updateSelectedSessionDuration,
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
          hintText: "e.g., Melbourne Crickett Ground",
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
                              shadowColor: AppColors.orange,
                              side: const BorderSide(color: AppColors.orange),
                              label: Text(
                                Utils.instance.formatDateToString(day),
                                style: const TextStyle(
                                  color: AppColors.orange,
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
          color: AppColors.appTheme,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Sizes.borderRadius),
          ),
        ),
        // leftChevronMargin: EdgeInsets.zero,
        leftChevronPadding: EdgeInsets.zero,
        // rightChevronMargin: EdgeInsets.zero,
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
        weekdayStyle: TextStyle(color: AppColors.blueGrey),
        weekendStyle: TextStyle(color: AppColors.orange),
      );

  ///CALENDAR STYLE
  CalendarStyle get calendarStyle => const CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: AppColors.appTheme,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Sizes.fontSize16,
          color: AppColors.white,
        ),
        todayDecoration: BoxDecoration(
          color: AppColors.blueGrey,
          shape: BoxShape.circle,
        ),
        disabledTextStyle: TextStyle(color: AppColors.grey),
        holidayTextStyle: TextStyle(color: AppColors.green),
        weekendTextStyle: TextStyle(color: AppColors.orange),
      );
}

///Available Time Slots
class _AvailableTimeSlots extends StatelessWidget {
  const _AvailableTimeSlots({
    required this.selectedTimeSlots,
    required this.onSelectTimeSlot,
  });

  final ValueListenable<String?> selectedTimeSlots;
  final void Function(String) onSelectTimeSlot;

  @override
  Widget build(BuildContext context) {
    return FormFiledWidget(
      title: "Available Time Slots",
      isRequired: true,
      child: ValueListenableBuilder<String?>(
        valueListenable: selectedTimeSlots,
        builder: (BuildContext context, String? value, Widget? child) {
          return Wrap(
            spacing: Sizes.space,
            children: List.generate(
              timeSlots.length,
              (index) {
                bool isActive = value != null && value == timeSlots[index];

                return ChoiceChip.elevated(
                  labelPadding: const EdgeInsets.symmetric(
                    horizontal: Sizes.spaceHeight * 1.6,
                  ),
                  labelStyle: TextStyle(
                    color: isActive ? AppColors.white : null,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
                  ),
                  onSelected: (data) {
                    onSelectTimeSlot(timeSlots[index]);
                  },
                  avatar: isActive
                      ? null
                      : const Icon(
                          CupertinoIcons.timer,
                          color: AppColors.black,
                        ),
                  label: Text(timeSlots[index]),
                  selected: isActive,
                );
              },
            ),
          );
        },
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

  final ValueNotifier<String?> selectedSessionDuration;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: selectedSessionDuration,
      builder: (BuildContext context, String? value, Widget? child) {
        return FormFiledWidget(
          title: "Session Duration",
          isRequired: true,
          child: DropdownButtonFormField<String>(
            padding: EdgeInsets.zero,
            menuMaxHeight: 300,
            alignment: Alignment.centerLeft,
            isExpanded: true,
            value: value,
            validator: FieldValidators.instance.commonValidator,
            items: duration.map((String valueItem) {
              return DropdownMenuItem<String>(
                value: valueItem,
                child: Text(
                  valueItem,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.blueGrey,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) onChanged(value);
            },
            decoration: const InputDecoration(),
          ),
        );
      },
    );
  }
}
