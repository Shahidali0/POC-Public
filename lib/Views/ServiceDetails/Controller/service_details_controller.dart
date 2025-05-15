import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

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

  //* Is Service Provided by Same User
  bool isSameUserService(String? providerId) {
    final user = _ref.read(userJsonPr)?.user;

    if (user == null) return true;

    return user.userId == providerId;
  }

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

  ///Handle left response
  Failure _handleLeft({
    required Either<Failure, dynamic> response,
    required BuildContext context,
  }) {
    Option<Failure> left = response.getLeft();

    Failure failure = left.toNullable()!;

    ///Error Snackbar
    showErrorSnackBar(
      context: context,
      title: failure.title,
      content: failure.message,
    );

    return failure;
  }

  ///Create  Booking
  FutureVoid createBooking({
    required BuildContext context,
    required ServiceJson serviceJson,
  }) async {
    try {
      state = state.copyWith(loading: true);

      ///STEP 1: Create Payment Intent
      final paymentIntentResponse =
          await _repository.createPaymentIntent(amount: serviceJson.price!);

      if (!context.mounted) return;

      if (paymentIntentResponse.isLeft()) {
        _handleLeft(response: paymentIntentResponse, context: context);
        return;
      }

      //Get Client Secret Here
      final clientSecret = paymentIntentResponse.getRight().toNullable()!;

      ///STEP 2: Make Payment
      final makePaymentResponse =
          await _repository.makePayment(clientSecret: clientSecret);

      ///STEP 3: Retrieve Payment Id
      String paymentId = clientSecret.split('_secret').first;

      if (!context.mounted) return;

      //! Any Exceptions in Make-Payment -- Handle and Update Status
      if (makePaymentResponse.isLeft()) {
        final failure =
            _handleLeft(context: context, response: makePaymentResponse);

        ///Update Payment Status
        await _updatePaymentStatus(
          serviceId: serviceJson.serviceId!,
          paymentId: paymentId,
          bookingId: "NO_ID",
          status: "FAILURE - ${failure.message}",
          context: context,
        );

        state = state.copyWith(loading: false);

        return;
      }

      //* No Exceptions
      await _saveBooking(
        serviceJson: serviceJson,
        paymentId: paymentId,
        context: context,
      );
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  //* Update the Payment Status
  FutureVoid _updatePaymentStatus({
    required String serviceId,
    required String paymentId,
    required String? bookingId,
    required String status,
    required BuildContext context,
  }) async {
    final updatePaymentResponse = await _repository.updatePaymentStatus(
      paymentId: paymentId,
      bookingId: bookingId,
      serviceId: serviceId,
      status: status,
    );

    updatePaymentResponse.fold(
      (failure) => showErrorSnackBar(
        context: context,
        title: failure.title,
        content: failure.message,
      ),
      (success) => null,
    );
  }

  //* Save Booking to DB
  FutureVoid _saveBooking({
    required ServiceJson serviceJson,
    required String paymentId,
    required BuildContext context,
  }) async {
    ///Load user
    final user = _ref.read(userJsonPr)?.user;

    ///Based on Duration and Selected Time get TimeSlots Range
    final timeSlots = _getActualTimeSlots();

    //STEP 4: Save Payment Details To DB
    final createBookingResponse = await _repository.saveBooking(
      serviceJson: serviceJson,
      user: user,
      selectedDate: state.selectedDate,
      selectedTimeSlot: timeSlots,
    );

    if (!context.mounted) return;

    //! If Any Exceptions
    if (createBookingResponse.isLeft()) {
      final failure =
          _handleLeft(context: context, response: createBookingResponse);

      ///Update Payment Status
      await _updatePaymentStatus(
        serviceId: serviceJson.serviceId!,
        paymentId: paymentId,
        bookingId: "NO_ID",
        status: "FAILURE - ${failure.message}",
        context: context,
      );

      return;
    }

    //* Success
    final successJson = createBookingResponse.getRight().toNullable()!;

    ///Update Payment Status
    await _updatePaymentStatus(
      serviceId: serviceJson.serviceId!,
      paymentId: paymentId,
      bookingId: successJson.bookingId,
      status: "SUCCESS",
      context: context,
    );

    if (!context.mounted) return;

    ///Go back
    AppRouter.instance.popUntil(context);

    ///Now Change BottomNav Index -- To see MyBooking
    _ref.read(navbarControllerPr.notifier).updateNavbarIndex(index: 3);

    ///Refresh Booking
    _ref.invalidate(getMyBookingsFtPr);

    showSuccessSnackBar(
      context: context,
      content: successJson.message,
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
