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

  //########################## API CALLS ############################
  //###############################################################

  FutureVoid makePayment({
    required BuildContext context,
    required ServiceJson serviceJson,
  }) async {
    state = state.copyWith(loading: true);

    final user = _ref.read(userJsonPr)?.user;

    final response = await _repository.makePayment(
      serviceJson: serviceJson,
      user: user,
      selectedDate: state.selectedDate,
      selectedTimeSlot: state.selectedTimeSlot,
    );

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
