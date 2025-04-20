import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

final serviceDetailsControllerPr = StateNotifierProvider.autoDispose<
    ServiceDetailsController, _ServiceDetailsState>(
  (ref) {
    return ServiceDetailsController(
      ref: ref,
      serviceDetailsRepo: ref.read(serviceDetailsRepositoryPr),
    );
  },
);

class ServiceDetailsController extends StateNotifier<_ServiceDetailsState> {
  final Ref _ref;
  final ServiceDetailsRepository _repository;

  ServiceDetailsController({
    required Ref ref,
    required ServiceDetailsRepository serviceDetailsRepo,
  })  : _repository = serviceDetailsRepo,
        _ref = ref,
        super(
          _ServiceDetailsState(
            selectedDate: "",
            selectedTimeSlot: "",
            selectedSessionDuration: "",
            loading: false,
          ),
        );

  //* Update Selected Date Value
  void updateSelectedDate(String value) {
    state = state.copyWith(selectedDate: value);
  }

  //* Update Selected TimeSlot Value
  void updateSelectedTimeSlot(String value) {
    state = state.copyWith(selectedTimeSlot: value);
  }

  //* Update Selected SessionDuration Value
  void updateSelectedSessionDuration(String value) {
    state = state.copyWith(selectedSessionDuration: value);
  }

  //* Add duration to selected time to get Actual TimeSlots
  String _getActualTimeSlots() {
    final selectedTimeSlot = state.selectedTimeSlot;
    final selectedDuration = state.selectedSessionDuration;

    /// Parse string to DateTime
    DateFormat format =
        DateFormat("hh:mm a"); // '"HH:mm:ss"' is like '10:20 AM'
    DateTime time = format.parse(selectedTimeSlot);

    /// Add Duration
    Duration duration = Duration(minutes: int.parse(selectedDuration));
    DateTime newTime = time.add(duration);

    /// Convert back to string
    String outputTime = format.format(newTime);

    return "$selectedTimeSlot - $outputTime";
  }

  //########################## API CALLS ############################
  //###############################################################

  FutureVoid makePayment({
    required BuildContext context,
    required ServiceJson serviceJson,
  }) async {
    state = state.copyWith(loading: true);

    final user = _ref.read(userJsonPr)?.user;

    ///Based on Duration and Selected Time get TimeSlots Range
    final timeSlots = _getActualTimeSlots();

    final response = await _repository.makePayment(
      serviceJson: serviceJson,
      user: user,
      selectedDate: state.selectedDate,
      selectedTimeSlot: timeSlots,
    );

    state = state.copyWith(loading: false);

    response.fold(
      (failure) => showErrorSnackBar(
        context: context,
        title: failure.title,
        content: failure.message,
      ),
      (success) {
        ///Go back
        AppRouter.instance.pop(context, rootNavigator: true);

        ///Now Change BottomNav Index -- To see MyBooking
        _ref.read(navbarControllerPr.notifier).updateNavbarIndex(index: 2);

        showSuccessSnackBar(
          context: context,
          content: success,
        );
      },
    );
  }
}

///ServiceDetails Model for holding and updating data

class _ServiceDetailsState {
  final String selectedDate;
  final String selectedTimeSlot;
  final String selectedSessionDuration;
  final bool loading;

  _ServiceDetailsState({
    required this.selectedDate,
    required this.selectedTimeSlot,
    required this.selectedSessionDuration,
    required this.loading,
  });

  _ServiceDetailsState copyWith({
    String? selectedDate,
    String? selectedTimeSlot,
    String? selectedSessionDuration,
    bool? loading,
  }) {
    return _ServiceDetailsState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      selectedSessionDuration:
          selectedSessionDuration ?? this.selectedSessionDuration,
      loading: loading ?? this.loading,
    );
  }
}
