import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BookServiceForm extends StatefulWidget {
  const BookServiceForm({super.key});

  @override
  State<BookServiceForm> createState() => _BookServiceFormState();
}

class _BookServiceFormState extends State<BookServiceForm> {
  late TextEditingController _dateController;
  late TextEditingController _nameController;

  final ValueNotifier<String?> _selectedTime = ValueNotifier(null);
  final ValueNotifier<String?> _selectedDuration = ValueNotifier(null);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _dateController = TextEditingController();
    _nameController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _nameController.dispose();
    _selectedTime.dispose();
    _selectedDuration.dispose();

    super.dispose();
  }

  ///Update Selected Time Value
  void _updateSelectedTime(String value) => _selectedTime.value = value;

  ///Update Selected Duration Value
  void _updateSelectedDuration(String value) => _selectedDuration.value = value;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DatePickerField(controller: _dateController),
            const _TimeSlotsField(),
            _DurationField(
              selectedDuration: _selectedDuration,
              onSelectDuration: _updateSelectedDuration,
            ),
            _NameField(controller: _nameController),
            const SizedBox(height: Sizes.spaceHeight),

            ///Continue Button
            CommonButton(
              onPressed: () {},
              text: "Continue",
            ),
          ],
        ),
      ),
    );
  }
}

///DatePicker Field
class _DatePickerField extends StatelessWidget {
  const _DatePickerField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FormFiledWidget(
      title: "Choose Date",
      isRequired: true,
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () => _showDatePicker(context),
        decoration: const InputDecoration(
          hintText: "Pick date",
          suffixIcon: Icon(CupertinoIcons.calendar),
        ),
      ),
    );
  }

  ///Show Date picker to pick date
  void _showDatePicker(BuildContext context) async {
    final slectedDate = await LogHelper.instance.showPlatformSpecificDatePicker(
      headerText: "Choose Booking Slot Date",
      context: context,
    );

    if (slectedDate == null) return;
    controller.text = Utils.instance.formatDateToString(slectedDate);
  }
}

///Time Slots
class _TimeSlotsField extends StatelessWidget {
  const _TimeSlotsField();

  @override
  Widget build(BuildContext context) {
    return const FormFiledWidget(
      title: "Choose Time",
      isRequired: true,
      child: Text(
        "No available time slots",
      ),
    );
  }
}

///Duration
class _DurationField extends StatelessWidget {
  const _DurationField({
    required this.selectedDuration,
    required this.onSelectDuration,
  });

  final ValueListenable<String?> selectedDuration;
  final void Function(String) onSelectDuration;

  @override
  Widget build(BuildContext context) {
    return FormFiledWidget(
      title: "Duration",
      isRequired: true,
      child: ValueListenableBuilder(
        valueListenable: selectedDuration,
        builder: (BuildContext context, String? value, Widget? child) {
          return Wrap(
            spacing: Sizes.space,
            children: List.generate(
              durationData.length,
              (index) {
                bool isActive = value != null && value == durationData[index];

                return ChoiceChip.elevated(
                  labelStyle: TextStyle(
                    color: isActive ? AppColors.white : null,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
                  ),
                  onSelected: (value) {
                    onSelectDuration(durationData[index]);
                    // ref.read(filterCategoryIndexPr.notifier).state = index;
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
          );
        },
      ),
    );
  }
}

///User Name Field
class _NameField extends StatelessWidget {
  const _NameField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FormFiledWidget(
      title: "Name",
      isRequired: true,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.name,
        validator: FieldValidators.instance.commonValidator,
        autofillHints: Formatter.instance.nameAutoFillHints,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(hintText: "John"),
      ),
    );
  }
}
