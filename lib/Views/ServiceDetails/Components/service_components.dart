part of 'package:cricket_poc/Views/ServiceDetails/service_details_screen.dart';

///DatePicker Field
class _DatePickerField extends ConsumerWidget {
  const _DatePickerField({
    required this.dates,
  });

  final List<String> dates;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(serviceDetailsControllerPr).selectedDate;

    return FormFiledWidget(
      title: "Choose Date",
      isRequired: true,
      child: Wrap(
        spacing: Sizes.spaceMed,
        children: dates.map(
          (item) {
            bool isActive = selectedDate == item;

            return ChoiceChip.elevated(
              labelStyle: TextStyle(
                color: isActive ? AppColors.white : null,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
              ),
              onSelected: (v) => ref
                  .read(serviceDetailsControllerPr.notifier)
                  .updateSelectedDate(item),
              avatar: isActive
                  ? null
                  : const Icon(
                      CupertinoIcons.calendar,
                      color: AppColors.black,
                    ),
              label: FittedBox(child: Text(item)),
              selected: isActive,
            );
          },
        ).toList(),
      ),
    );
  }
}

///Time Slots
class _TimeSlotsField extends ConsumerWidget {
  const _TimeSlotsField({
    required this.timeSlotsData,
  });

  final List<String> timeSlotsData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTimeSlot =
        ref.watch(serviceDetailsControllerPr).selectedTimeSlot;

    return FormFiledWidget(
      title: "Choose Time",
      isRequired: true,
      child: Wrap(
        spacing: Sizes.spaceMed,
        children: timeSlotsData.map(
          (item) {
            bool isActive = selectedTimeSlot == item;

            return ChoiceChip.elevated(
              labelStyle: TextStyle(
                color: isActive ? AppColors.white : null,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
              ),
              onSelected: (v) => ref
                  .read(serviceDetailsControllerPr.notifier)
                  .updateSelectedTimeSlot(item),
              avatar: isActive
                  ? null
                  : const Icon(
                      CupertinoIcons.time,
                      color: AppColors.black,
                    ),
              label: FittedBox(child: Text(item)),
              selected: isActive,
            );
          },
        ).toList(),
      ),
    );
  }
}

///Duration
class _DurationField extends ConsumerWidget {
  const _DurationField({
    required this.sessionDurations,
  });

  final List<String> sessionDurations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDuration =
        ref.watch(serviceDetailsControllerPr).selectedSessionDuration;

    return FormFiledWidget(
      title: "Choose Duration",
      isRequired: true,
      child: Wrap(
        spacing: Sizes.space,
        children: sessionDurations.map(
          (item) {
            bool isActive = selectedDuration == item;

            return ChoiceChip.elevated(
              labelStyle: TextStyle(
                color: isActive ? AppColors.white : null,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
              ),
              onSelected: (value) => ref
                  .read(serviceDetailsControllerPr.notifier)
                  .updateSelectedSessionDuration(item),
              avatar: isActive
                  ? null
                  : const Icon(
                      CupertinoIcons.timer,
                      color: AppColors.black,
                    ),
              label: Text("$item min"),
              selected: isActive,
            );
          },
        ).toList(),
      ),
    );
  }
}
