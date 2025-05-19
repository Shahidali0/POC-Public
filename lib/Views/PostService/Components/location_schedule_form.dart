part of 'package:cricket_poc/Views/PostService/post_service_screen.dart';

class _LocationScheduleForm extends ConsumerWidget {
  const _LocationScheduleForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(postServiceControllerPr.notifier);

    return GestureDetector(
      onTap: () {
        Utils.instance.hideFoucs(context);
      },
      child: Form(
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
            _LocationField(
              controller: controller.locationController,
            ),

            ///Available Dates
            _AvailableDates(ref: ref),
            _ValidationErrorMessage(listenable: controller.datesValidation),

            ///Available Time Slots
            _AvailableTimeSlots(
              controller: controller,
              ref: ref,
            ),
            _ValidationErrorMessage(listenable: controller.timeSlotValidation),

            ///Session Duration
            _SessionDurationField(
              controller: controller,
              ref: ref,
            ),
            _ValidationErrorMessage(
              listenable: controller.sessionDurationValidation,
            ),

            const SizedBox(height: Sizes.spaceHeight),
          ],
        ),
      ),
    );
  }
}

///Location Field
class _LocationField extends ConsumerWidget {
  const _LocationField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locations = ref.watch(postServiceControllerPr).locations;

    return FormFiledWidget(
      title: "Location",
      isRequired: true,
      child: StatefulBuilder(
        builder: (context, setState) {
          return TypeAheadField<LocationsJson>(
            controller: controller,
            onSelected: (LocationsJson value) {
              controller.text = value.location!;

              setState(() {});
            },

            ///Show items
            itemBuilder: (BuildContext context, LocationsJson locationJson) {
              return ListTile(
                title: Text(locationJson.location!),
                subtitle: Text(locationJson.postcode!),
              );
            },

            ///TextField Decoration
            builder: (context, editingController, focusNode) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                keyboardType: TextInputType.name,
                validator: FieldValidators.instance.commonValidator,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: "e.g., 2786 or Parklea",
                ),
              );
            },

            ///Suggestions
            suggestionsCallback: (String search) {
              if (search.isEmpty) {
                return List<LocationsJson>.empty();
              }
              return locations.where(
                (LocationsJson option) {
                  final result = option.postcode!
                          .toLowerCase()
                          .contains(search.toLowerCase()) ||
                      option.location!
                          .toLowerCase()
                          .contains(search.toLowerCase());

                  return result;
                },
              ).toList();
            },
          );
        },
      ),

      // child: StatefulBuilder(
      //   builder: (context, setState) {
      //     return Autocomplete<LocationsJson>(
      //       optionsMaxHeight: 300,

      //       ///Options
      //       optionsBuilder: (TextEditingValue textEditingValue) {
      //         if (textEditingValue.text.isEmpty) {
      //           return const Iterable<LocationsJson>.empty();
      //         }
      //         return locations.where(
      //           (LocationsJson option) {
      //             final result = option.postcode!.toLowerCase().contains(
      //                       textEditingValue.text.toLowerCase(),
      //                     ) ||
      //                 option.location!.contains(
      //                   textEditingValue.text.toLowerCase(),
      //                 );

      //             return result;
      //           },
      //         );
      //       },
      //       onSelected: (LocationsJson locationJson) {
      //         controller.text = locationJson.location!;
      //         print(locationJson.location);
      //         setState(() {});
      //       },
      //       displayStringForOption: (LocationsJson option) => option.location!,

      //       ///FieldView
      //       fieldViewBuilder:
      //           (context, eController, focusNode, onFieldSubmitted) {
      //         return TextField(
      //           onSubmitted: (String selection) => onFieldSubmitted(),
      //           focusNode: focusNode,
      //           controller: controller,
      //           keyboardType: TextInputType.name,
      //           // validator: FieldValidators.instance.commonValidator,
      //           textCapitalization: TextCapitalization.words,
      //           decoration: const InputDecoration(
      //             hintText: "e.g., 2786 or Parklea",
      //           ),
      //         );
      //       },

      //       // ///Options View Builder
      //       // optionsViewBuilder: (context, onSelected, options) {
      //       //   return Align(
      //       //     alignment: Alignment.topLeft,
      //       //     child: Material(
      //       //       shape: ContinuousRectangleBorder(
      //       //         borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
      //       //       ),
      //       //       elevation: 4,
      //       //       child: ListView.builder(
      //       //         padding: EdgeInsets.zero,
      //       //         itemCount: options.length,
      //       //         itemBuilder: (context, index) {
      //       //           final LocationsJson option = options.elementAt(index);
      //       //           return ListTile(
      //       //             title: Text(option.location!),
      //       //             subtitle: Text('Code: ${option.postcode}'),
      //       //             onTap: () => onSelected(option),
      //       //           );
      //       //         },
      //       //       ),
      //       //     ),
      //       //   );
      //       // },
      //     );
      //   },
      // ),

      ///
      // child: TextFormField(
      //   controller: controller,
      //   keyboardType: TextInputType.name,
      //   validator: FieldValidators.instance.commonValidator,
      //   textCapitalization: TextCapitalization.words,
      //   decoration: const InputDecoration(
      //     hintText: "e.g., Melbourne Cricket Ground",
      //   ),
      // ),
    );
  }
}

///Available Dates
class _AvailableDates extends StatelessWidget {
  const _AvailableDates({
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final selectedDates = ref.watch(postServiceControllerPr).selectedDates;

    DateTime focusedDay = DateTime.now();

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
              selectedDayPredicate: (day) => selectedDates.contains(day),
              onDaySelected:
                  (DateTime selectedDayValue, DateTime focusedDayValue) {
                focusedDay = focusedDayValue;

                ///Update Status
                ref
                    .read(postServiceControllerPr.notifier)
                    .updateSelectedDates(selectedDayValue);
              },
              onPageChanged: (DateTime date) => focusedDay = date,
            ),
          ),

          ///Selected Days
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              bottom: Sizes.spaceMed,
              top: Sizes.spaceMed,
            ),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: selectedDates
                  .map(
                    (day) => Padding(
                      padding: const EdgeInsets.only(right: Sizes.spaceMed),
                      child: Chip(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Sizes.borderRadius),
                          side: const BorderSide(color: AppColors.lightBlue),
                        ),
                        label: Text(
                          day.formatDateToString,
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
        ],
      ),
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
    required this.controller,
    required this.ref,
  });

  final PostServiceController controller;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final timeSlots = ref.watch(postServiceControllerPr).selectedTimeSlots;
    final width = Sizes.screenWidth(context);

    return FormFiledWidget(
      title: "Available Time Slots",
      isRequired: true,
      child: SizedBox(
        width: width,
        height: 160,
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: Sizes.spaceMed),
          primary: false,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.5,
            crossAxisSpacing: 8,
          ),
          itemCount: timeSlotsData.length,
          itemBuilder: (BuildContext context, int index) {
            final item = timeSlotsData[index];
            bool isActive = timeSlots.contains(item);

            return ChoiceChip.elevated(
              labelStyle: TextStyle(
                color: isActive ? AppColors.white : null,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
              ),
              onSelected: (v) => ref
                  .read(postServiceControllerPr.notifier)
                  .updateSelectedTimeSlots(item),
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
        ),
      ),
    );
  }
}

///Session Duration
class _SessionDurationField extends StatelessWidget {
  const _SessionDurationField({
    required this.controller,
    required this.ref,
  });

  final PostServiceController controller;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final duration = ref.watch(postServiceControllerPr).selectedSessionDuration;

    return FormFiledWidget(
      title: "Session Duration",
      isRequired: true,
      child: Padding(
        padding: const EdgeInsets.only(top: Sizes.spaceMed),
        child: Wrap(
          spacing: Sizes.spaceMed,
          alignment: WrapAlignment.spaceAround,
          children: List.generate(
            durationData.length,
            (index) {
              final item = durationData[index];
              bool isActive = duration.contains(item);

              return ChoiceChip.elevated(
                labelPadding: const EdgeInsets.symmetric(
                  vertical: Sizes.spaceSmall,
                  horizontal: Sizes.space,
                ),
                labelStyle: TextStyle(
                  color: isActive ? AppColors.white : null,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
                ),
                onSelected: (v) => ref
                    .read(postServiceControllerPr.notifier)
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
          ),
        ),
      ),
    );
  }
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
