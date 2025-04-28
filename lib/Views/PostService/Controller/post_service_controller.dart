part of 'package:cricket_poc/Views/PostService/post_service_screen.dart';

final postServiceControllerPr = StateNotifierProvider.autoDispose<
    PostServiceController, _PostServiceStatus>(
  (ref) => PostServiceController(
    ref: ref,
    postServiceRepo: ref.read(postServicesRepositoryPr),
  ),
);

final _stepperIndexPr = StateProvider.autoDispose<int>((ref) => 0);

class PostServiceController extends StateNotifier<_PostServiceStatus> {
  final Ref _ref;
  final PostServicesRepository _repository;

  PostServiceController({
    required Ref ref,
    required PostServicesRepository postServiceRepo,
  })  : _ref = ref,
        _repository = postServiceRepo,
        super(
          _PostServiceStatus(
            selectedSport: null,
            selectedCategory: null,
            selectedSubCategory: null,
            selectedTimeSlots: [],
            selectedSessionDuration: [],

            /// For MULTI-DATE_PICKER:
            /// Using a `LinkedHashSet` is recommended due to equality comparison override
            selectedDates: LinkedHashSet<DateTime>(
              equals: isSameDay,
              hashCode: Utils.instance.getHashCode,
            ),
            loading: false,
          ),
        );

  ///FormKeys
  GlobalKey<FormState> serviceDetailsFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> locationScheduleFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> pricingFormKey = GlobalKey<FormState>();

  late ScrollController scrollController;

  List<CategoryJson> allCategories = [];

  ///Editing Controller
  late TextEditingController serviceTitleController;
  late TextEditingController serviceDescriptionController;
  late TextEditingController locationController;
  late TextEditingController priceController;

  ///Error Validations
  // late ValueNotifier<String> sportValidation;
  late ValueNotifier<String> categoryValidation;
  late ValueNotifier<String> subCategoryValidation;
  late ValueNotifier<String> datesValidation;
  late ValueNotifier<String> timeSlotValidation;
  late ValueNotifier<String> sessionDurationValidation;

  //* Initialize the data
  void initState() {
    scrollController = ScrollController();
    allCategories = _ref.read(allCategoriesPr);

    serviceTitleController = TextEditingController();
    serviceDescriptionController = TextEditingController();
    priceController = TextEditingController();
    locationController = TextEditingController();

    ///For Validations
    // sportValidation = ValueNotifier("");
    categoryValidation = ValueNotifier("");
    subCategoryValidation = ValueNotifier("");
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

    // sportValidation.dispose();
    categoryValidation.dispose();
    subCategoryValidation.dispose();
    datesValidation.dispose();
    timeSlotValidation.dispose();
    sessionDurationValidation.dispose();

    super.dispose();
  }

  //* Get All Categories
  FutureVoid loadAllCategories() async {
    if (!mounted) return;
    state = state.copyWith(loading: true);

    allCategories =
        await _ref.read(navbarControllerPr.notifier).getAllCategories();

    state = state.copyWith(loading: false);
  }

  //*Get Sports List
  List<String> get getSportsData =>
      allCategories.map((e) => e.sport!).toSet().toList();

  //*Get Categories List
  List<String> get getCategoriesData {
    final filteredCategories = allCategories
        .where((item) => item.sport == state.selectedSport)
        .toList();

    return filteredCategories.map((e) => e.category!).toSet().toList();
  }

  //*Get SubCategories List
  List<String> get getSubCategoriesData {
    final filteredList = allCategories
        .where((item) =>
            item.category == state.selectedCategory &&
            item.sport == state.selectedSport)
        .firstOrNull;

    return filteredList?.subcategories ?? [];
  }

  //* Service Sport Update Function
  void updateSelectedSport(String? value) {
    state = state.copyWith(
      selectedSport: value,
      selectedCategory: '',
      selectedSubCategory: '',
    );
    debugPrint(
      "Sport:${state.selectedSport}--Category:${state.selectedCategory}--SubCategory:${state.selectedSubCategory}",
    );
  }

  //* Service Category Update Function
  void updateSelectedCategory(String? value) {
    state = state.copyWith(
      selectedCategory: value,
      selectedSubCategory: '',
    );
    debugPrint(
      "Sport:${state.selectedSport}--Category:${state.selectedCategory}--SubCategory:${state.selectedSubCategory}",
    );
  }

  //* Service Sub-Category Update Function
  void updateSelectedSubCategory(String? value) {
    state = state.copyWith(
      selectedSubCategory: value,
    );
    debugPrint(
      "Sport:${state.selectedSport}--Category:${state.selectedCategory}--SubCategory:${state.selectedSubCategory}",
    );
  }

  //* Update Selected Dates Value
  void updateSelectedDates(DateTime value) {
    final selectedDates = state.selectedDates;
    List<DateTime> selectedList = [];

    ///Check if value already exist , if [yes] remove the item
    if (selectedDates.contains(value)) {
      selectedList =
          state.selectedDates.where((item) => item != value).toList();
    }

    /// if [No] add that item to list
    else {
      selectedList = [...state.selectedDates, value];
    }

    ///Sort Selected Dates
    selectedList.sort((a, b) => a.compareTo(b));

    ///Update State
    state = state.copyWith(selectedDates: selectedList.toSet());
  }

  //* Update Selected TimeSlot Value
  void updateSelectedTimeSlots(String value) {
    final timeSlots = state.selectedTimeSlots;
    List<String> selectedList = [];

    ///Check if value already exist , if [yes] remove the item
    if (timeSlots.contains(value)) {
      selectedList =
          state.selectedTimeSlots.where((item) => item != value).toList();
    }

    /// if [No] add that item to list
    else {
      selectedList = [...state.selectedTimeSlots, value];
    }

    /// Define a DateFormat for 12-hour time parsing
    DateFormat inputFormat = DateFormat("hh:mm a");

    ///Sort Method
    selectedList.sort((a, b) {
      DateTime timeA = inputFormat.parse(a); // Convert to DateTime
      DateTime timeB = inputFormat.parse(b);
      return timeA.compareTo(timeB); // Compare times
    });

    ///Update State
    state = state.copyWith(selectedTimeSlots: selectedList);
  }

  //* Update Selected Session Duration Value
  void updateSelectedSessionDuration(String value) {
    final sessionDuration = state.selectedSessionDuration;
    List<String> selectedList = [];

    ///Check if value already exist , if [yes] remove the item
    if (sessionDuration.contains(value)) {
      selectedList =
          state.selectedSessionDuration.where((item) => item != value).toList();
    }

    /// if [No] add that item to list
    else {
      selectedList = [...state.selectedSessionDuration, value];
    }

    /// Sort Method
    selectedList.sort((a, b) {
      int numA = int.parse(a.split(" ")[0]); // Extract number from string
      int numB = int.parse(b.split(" ")[0]);
      return numA.compareTo(numB); // Compare numbers
    });

    ///Update State with SessionDuration Sorted List
    state = state.copyWith(selectedSessionDuration: selectedList);
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
        _handleServiceDetailsFromValidation(context);
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
  void _handleServiceDetailsFromValidation(BuildContext context) {
    final validate = validateForm(serviceDetailsFormKey);
    final isSportEmpty = state.selectedSport == null;
    final isCategoryEmpty = state.selectedCategory == null;
    final isSubCategoryEmpty = state.selectedSubCategory == null;

    ///Update Specific Validation Error Message
    // sportValidation.value = isSportEmpty ? "Kindly select the Sport" : "";
    categoryValidation.value =
        isCategoryEmpty ? "Kindly select your preferred Category" : "";
    subCategoryValidation.value =
        isSubCategoryEmpty ? "Kindly select your preferred SubCategory" : "";

    //! Common Error Message
    if (!validate || isSportEmpty || isCategoryEmpty || isSubCategoryEmpty) {
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

  ///Handle Location Schedule Page Validations
  void _handleLocationFromValidation(BuildContext context) {
    final validate = validateForm(locationScheduleFormKey);
    final isDaysEmpty = state.selectedDates.isEmpty;
    final isTimeSlotsEmpty = state.selectedTimeSlots.isEmpty;
    final isSessionDurationEmpty = state.selectedSessionDuration.isEmpty;

    ///Update Specific Validation Error Message
    datesValidation.value =
        isDaysEmpty ? "Kindly select your Available Dates" : "";
    timeSlotValidation.value =
        isTimeSlotsEmpty ? "Kindly select your Available Time-Slots " : "";
    sessionDurationValidation.value = isSessionDurationEmpty
        ? "Kindly select your preferred Session Duration"
        : "";

    //! Common Error Message
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
        page: const PostServiceReviewScreen(),
      );
    }
  }

  ///Get TimeSlots Data
  Map<String, List<String>> _getTimeSlotsData() {
    ///Sort Selected Dates
    List<DateTime> sortedDates = state.selectedDates.toList();

    Map<String, List<String>> data = {};

    for (var day in sortedDates) {
      final currentDay = Utils.instance.formatDateToString(day);

      data[currentDay] = state.selectedTimeSlots;
    }

    return data;
  }

  //########################## API CALLS ############################
  //###############################################################

  //* Post the Service to API
  void postService(BuildContext context) async {
    state = state.copyWith(loading: true);

    ///Get Time Slots
    final timeSlots = _getTimeSlotsData();

    ///Get Userid
    final userId = _ref.read(profileControllerPr.notifier).getUserId();

    ///If No userId then return Alert
    if (userId.isEmpty) {
      showErrorSnackBar(
        context: context,
        content: "User not found",
      );
      return;
    }

    ///PostServiceDto
    final postServiceDto = PostServiceDto(
      providerId: userId,
      title: serviceTitleController.text.trim(),
      sport: state.selectedSport!,
      description: serviceDescriptionController.text.trim(),
      duration: state.selectedSessionDuration,
      location: locationController.text.trim(),
      price: int.parse(priceController.text.trim()),
      category: state.selectedCategory!,
      subcategory: state.selectedSubCategory!,
      timeSlots: timeSlots,
    );

    final response =
        await _repository.postService(postServiceDto: postServiceDto);

    state = state.copyWith(loading: false);

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
        AppRouter.instance.popUntil(context);

        ///After posting the service Update Bottom navbar index to
        ///FindService index to see the posted service
        _ref.read(navbarControllerPr.notifier).updateNavbarIndex(index: 1);

        return;
      },
    );
  }
}

///PostService Model for holding and updating status
class _PostServiceStatus {
  String? selectedSport;
  String? selectedCategory;
  String? selectedSubCategory;
  List<String> selectedTimeSlots;
  List<String> selectedSessionDuration;
  Set<DateTime> selectedDates;
  bool loading;

  _PostServiceStatus({
    required this.selectedSport,
    required this.selectedCategory,
    required this.selectedSubCategory,
    required this.selectedTimeSlots,
    required this.selectedSessionDuration,
    required this.selectedDates,
    required this.loading,
  });

  _PostServiceStatus copyWith({
    String? selectedSport,
    String? selectedCategory,
    String? selectedSubCategory,
    List<String>? selectedTimeSlots,
    List<String>? selectedSessionDuration,
    Set<DateTime>? selectedDates,
    bool? loading,
  }) {
    return _PostServiceStatus(
      selectedSport:
          ((selectedSport?.isEmpty ?? false) ? null : selectedSport) ??
              this.selectedSport,
      selectedCategory:
          ((selectedCategory?.isEmpty ?? false) ? null : selectedCategory) ??
              this.selectedCategory,
      selectedSubCategory: ((selectedSubCategory?.isEmpty ?? false)
              ? null
              : selectedSubCategory) ??
          this.selectedSubCategory,
      selectedTimeSlots: selectedTimeSlots ?? this.selectedTimeSlots,
      selectedSessionDuration:
          selectedSessionDuration ?? this.selectedSessionDuration,
      selectedDates: selectedDates ?? this.selectedDates,
      loading: loading ?? this.loading,
    );
  }
}
