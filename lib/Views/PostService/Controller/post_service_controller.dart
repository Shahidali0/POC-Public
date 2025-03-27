part of 'package:cricket_poc/Views/PostService/post_service_screen.dart';

final postServiceControllerPr =
    StateNotifierProvider<PostServiceRepository, bool>(
  (ref) => PostServiceRepository(
    ref: ref,
    postServiceRepo: ref.read(postServicesRepositoryPr),
  ),
);

final _stepperIndexPr = StateProvider.autoDispose<int>((ref) => 0);

class PostServiceRepository extends StateNotifier<bool> {
  final Ref _ref;
  final PostServicesRepository _repository;

  PostServiceRepository({
    required Ref ref,
    required PostServicesRepository postServiceRepo,
  })  : _ref = ref,
        _repository = postServiceRepo,
        super(false);

  ///FormKeys
  GlobalKey<FormState> serviceDetailsFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> locationScheduleFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> pricingFormKey = GlobalKey<FormState>();

  late ScrollController scrollController;

  ///Editing Controller
  late TextEditingController serviceTitleController;
  late TextEditingController serviceDescriptionController;
  late TextEditingController locationController;
  late TextEditingController priceController;

  ///Listenables
  late ValueNotifier<String?> selectedServiceCategory;
  late ValueNotifier<List<String>> selectedTimeSlotsListenable;
  late ValueNotifier<List<String>> selectedSessionDurationListenable;

  ///For Multi-Dates-Picker
  late Set<DateTime> selectedDays;

  ///Error Validations
  late ValueNotifier<String> datesValidation;
  late ValueNotifier<String> timeSlotValidation;
  late ValueNotifier<String> sessionDurationValidation;

  //* Initialize the data
  void initState() {
    scrollController = ScrollController();

    serviceTitleController = TextEditingController();
    serviceDescriptionController = TextEditingController();
    priceController = TextEditingController();
    locationController = TextEditingController();

    selectedServiceCategory = ValueNotifier(null);
    selectedTimeSlotsListenable = ValueNotifier([]);
    selectedSessionDurationListenable = ValueNotifier([]);

    /// For MULTI-DATE_PICKER:
    /// Using a `LinkedHashSet` is recommended due to equality comparison override
    selectedDays = LinkedHashSet<DateTime>(
      equals: isSameDay,
      hashCode: Utils.instance.getHashCode,
    );

    ///For Validations
    datesValidation = ValueNotifier("");
    timeSlotValidation = ValueNotifier("");
    sessionDurationValidation = ValueNotifier("");
  }

  //* Dispose the State
  @override
  void dispose() {
    scrollController.dispose();

    serviceTitleController.dispose();
    serviceDescriptionController.dispose();
    priceController.dispose();
    locationController.dispose();

    selectedServiceCategory.dispose();
    selectedTimeSlotsListenable.dispose();
    selectedSessionDurationListenable.dispose();

    datesValidation.dispose();
    timeSlotValidation.dispose();
    sessionDurationValidation.dispose();

    super.dispose();
  }

  //* Service Category Update Function
  void handleServiceCategoryChanged(String? value) {
    if (value == null) {
      selectedServiceCategory = ValueNotifier(null);
      return;
    }

    selectedServiceCategory = ValueNotifier(value);
    debugPrint("_selectedIdType:${selectedServiceCategory.value}");
  }

  //* Update Selected TimeSlot Value
  void updateSelectedTimeSlots(String value) {
    ///Check if value already exist , if [yes] remove the item
    if (selectedTimeSlotsListenable.value.contains(value)) {
      selectedTimeSlotsListenable.value =
          List.from(selectedTimeSlotsListenable.value)..remove(value);
    }

    /// if [No] add that item to list
    else {
      selectedTimeSlotsListenable.value =
          List.from(selectedTimeSlotsListenable.value)..add(value);
    }
  }

  //* Update Selected Session Duration Value
  void updateSelectedSessionDuration(String value) {
    ///Check if value already exist , if [yes] remove the item
    if (selectedSessionDurationListenable.value.contains(value)) {
      selectedSessionDurationListenable.value =
          List.from(selectedSessionDurationListenable.value)..remove(value);
    }

    /// if [No] add that item to list
    else {
      selectedSessionDurationListenable.value =
          List.from(selectedSessionDurationListenable.value)..add(value);
    }
  }

  ///MOVE TO TOP
  void _moveTotop() => scrollController.animateTo(
        0,
        duration: Sizes.duration,
        curve: Sizes.curve,
      );

  ///ON STEP TAPPED
  void onStepTapped({
    required int step,
    required int currentStep,
  }) {
    if (currentStep >= step) {
      _ref.read(_stepperIndexPr.notifier).update((state) => state = step);
    }
  }

  ///ON STEP CONTINUE
  void onStepContinue({
    required BuildContext context,
    required int currentStep,
  }) {
    ///This is fix ScrollIssues
    _moveTotop();

    ///Handle Validations
    switch (currentStep) {
      case 0:
        _handleServiceDetailsFromValidation();
        break;

      case 1:
        _handleLocationFromValidation(context);
        break;

      case 2:
        _handlePricingFromValidation(context);
        break;

      default:
    }
  }

  ///ON STEP CANCEL
  void onStepCancel(int currentStep) {
    if (currentStep > 0) {
      ///This is fix ScrollIssues
      _moveTotop();
      _ref.read(_stepperIndexPr.notifier).update((state) => state -= 1);
    }
  }

  //########################## VALIDATIONS ############################
  //###############################################################

  ///Handle Service Details Page Validations
  void _handleServiceDetailsFromValidation() {
    final validate = validateForm(serviceDetailsFormKey);

    if (validate) {
      _ref.read(_stepperIndexPr.notifier).update((state) => state += 1);
    }
  }

  ///Handle Location Schedule Page Validations
  void _handleLocationFromValidation(BuildContext context) {
    final validate = validateForm(locationScheduleFormKey);
    final isDaysEmpty = selectedDays.isEmpty;
    final isTimeSlotsEmpty = selectedTimeSlotsListenable.value.isEmpty;
    final isSessionDurationEmpty =
        selectedSessionDurationListenable.value.isEmpty;

    ///Update Specific Validation Error Message
    datesValidation.value =
        isDaysEmpty ? "Kindly select your Available Dates" : "";
    timeSlotValidation.value =
        isTimeSlotsEmpty ? "Kindly select your Available Time-Slots " : "";
    sessionDurationValidation.value = isSessionDurationEmpty
        ? "Kindly select your preferred Session Duration"
        : "";

    ///Common Error Message
    if (!validate ||
        isDaysEmpty ||
        isTimeSlotsEmpty ||
        isSessionDurationEmpty) {
      showErrorSnackBar(
        context: context,
        content: AppExceptions.instance.requiredYourInput,
      );
      return;
    }

    ///Else Update the Stepper Index to move forward
    else {
      _ref.read(_stepperIndexPr.notifier).update((state) => state += 1);
    }
  }

  ///Handle Pricing Page Validations
  void _handlePricingFromValidation(BuildContext context) {
    final validate = validateForm(pricingFormKey);

    if (validate) {
      AppRouter.instance.push(
        context: context,
        screen: const PostServiceReviewScreen(),
      );
    }
  }

  ///Get TimeSlots Data
  Map<String, List<String>> _getTimeSlotsData(List<DateTime> sortedDates) {
    Map<String, List<String>> data = {};

    for (var day in sortedDates) {
      final currentDay = Utils.instance.formatDateToString(day);

      data[currentDay] = selectedTimeSlotsListenable.value;
    }

    return data;
  }

//* Post the Service to API
  void postService(BuildContext context) async {
    state = true;

    ///Sort Selected TimeSlots
    selectedTimeSlotsListenable.value.sort();

    ///Sort Session Durations
    selectedSessionDurationListenable.value.sort();

    ///Sort Selected Dates
    List<DateTime> sortedDates = selectedDays.toList();
    sortedDates.sort((a, b) => a.compareTo(b));

    ///Get Time Slots
    final timeSlots = _getTimeSlotsData(sortedDates);

    final postServiceDto = PostServiceDto(
      providerId: "123asf234234",
      title: serviceTitleController.text.trim(),
      sport: "Cricket",
      description: serviceDescriptionController.text.trim(),
      duration: selectedSessionDurationListenable.value,
      location: locationController.text.trim(),
      price: int.parse(priceController.text.trim()),
      category: selectedServiceCategory.value!,
      subcategory: "battingCoaching",
      timeSlots: timeSlots,
    );

    final response =
        await _repository.postService(postServiceDto: postServiceDto);

    state = false;

    response.fold(
      (failure) => showErrorSnackBar(
        context: context,
        title: failure.title,
        content: failure.message,
      ),
      (success) {
        showSuccessSnackBar(
          context: context,
          content: success,
        );
        return AppRouter.instance.pushOff(
          context: context,
          screen: const DashboardNavbarScreen(),
        );
      },
    );
  }
}
