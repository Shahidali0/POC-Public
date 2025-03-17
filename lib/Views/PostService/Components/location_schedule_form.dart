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
  late CalendarDatePicker2Config config;

  final ValueNotifier<String?> _selectedTimeSlots = ValueNotifier(null);
  final ValueNotifier<String> _selectedSessionDuration =
      ValueNotifier(duration[0]);

  // static final today = DateUtils.dateOnly(DateTime.now());

  // List<DateTime?> _multiDatePickerValueWithDefaultValue = [
  //   DateTime(today.year, today.month, 1),
  //   DateTime(today.year, today.month, 5),
  //   DateTime(today.year, today.month, 14),
  //   DateTime(today.year, today.month, 17),
  //   DateTime(today.year, today.month, 25),
  // ];

  @override
  void initState() {
    _locationController = TextEditingController();
    config = CalendarDatePicker2Config(
      dayModeScrollDirection: Axis.horizontal,
      disableMonthPicker: true,
      calendarType: CalendarDatePicker2Type.multi,
      selectedDayHighlightColor: Colors.indigo,
    );
    super.initState();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  ///Update Selected TimeSlot Value
  void _updateSelectedTimeSlots(String value) =>
      _selectedTimeSlots.value = value;

  ///Update Selected Session Duration Value
  void _updateSelectedSessionDuration(String value) {
    _selectedSessionDuration.value = value;
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
          _AvailableDates(
            config: config,
          ),

          ///Available Time Slots
          _AvailableTimeSlots(
            selectedTimeSlots: _selectedTimeSlots,
            onSelectTimeSlot: _updateSelectedTimeSlots,
          ),

          ///Session Duration
          _SessionDurationField(
            selectedSessionDuration: _selectedSessionDuration,
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
    required this.config,
  });

  final CalendarDatePicker2Config config;

  @override
  Widget build(BuildContext context) {
    return FormFiledWidget(
      title: "Available Dates",
      isRequired: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 300,
            child: CalendarDatePicker2(
              config: config,
              value: const [],
              onValueChanged: (dates) {
                print(dates);
              },
            ),
          ),
          const SizedBox(height: 10),
          const Wrap(
            children: [
              Text('Selection(s):  '),
              SizedBox(width: 10),
              // Text(
              //   _getValueText(
              //     config.calendarType,
              //     _multiDatePickerValueWithDefaultValue,
              //   ),
              //   overflow: TextOverflow.ellipsis,
              //   maxLines: 1,
              //   softWrap: false,
              // ),
            ],
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }
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
      child: ValueListenableBuilder(
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
                      horizontal: Sizes.spaceHeight * 2),
                  labelStyle: TextStyle(
                    color: isActive ? AppColors.white : null,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
                  ),
                  onSelected: (value) {
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
