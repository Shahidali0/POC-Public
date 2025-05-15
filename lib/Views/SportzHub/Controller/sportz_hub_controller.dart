import 'package:flutter/material.dart';

import 'package:cricket_poc/lib_exports.dart';

final sportzHubControllerPr = StateNotifierProvider.autoDispose<
    SportzHubController, _SportzHubControllerStatus>(
  (ref) => SportzHubController(
    ref: ref,
    sportzHubRepo: ref.read(sportzHubRepositoryPr),
  ),
);

final myBookingSegemntIndexPr = StateProvider<MyBookingType>(
  (ref) => MyBookingType.upcoming,
);

final getMyServicesListFtPr = FutureProvider<AllServicesJson?>((ref) async {
  return ref.read(sportzHubControllerPr.notifier).getMyServicesList();
});

final getMyBookingsFtPr = FutureProvider<List<BookingsJson>>((ref) async {
  return ref.read(sportzHubControllerPr.notifier).getMyBookingsList();
});

final getMyServicesBookingsFtPr = FutureProvider.family
    .autoDispose<List<BookingsJson>, String>((ref, String serviceId) async {
  return ref
      .read(sportzHubControllerPr.notifier)
      .getMyServicesBookingList(serviceId: serviceId);
});

class SportzHubController extends StateNotifier<_SportzHubControllerStatus> {
  final SportzHubRepository _repository;
  final Ref _ref;

  SportzHubController({
    required SportzHubRepository sportzHubRepo,
    required Ref ref,
  })  : _repository = sportzHubRepo,
        _ref = ref,
        super(
          _SportzHubControllerStatus(loadingId: ""),
        );

  //* Get My Services
  Future<AllServicesJson?> getMyServicesList() =>
      _repository.getMyServicesList();

  // //* Get My Services -- Bookings List
  Future<List<BookingsJson>> getMyServicesBookingList({
    required String serviceId,
  }) =>
      _repository.getMyServicesBookings(serviceId: serviceId);

  //* Get User Bookings List
  Future<List<BookingsJson>> getMyBookingsList() => _repository.getMyBookings();

  //* Update My Service Booking Status
  FutureVoid updateMyServiceBookingStatus({
    required BuildContext context,
    required String providerId,
    required String bookingId,
    required BookingStatus status,
  }) async {
    ///Assign booking Id to state so that the particular item
    ///Should show loading indicator
    state = state.copyWith(loadingId: bookingId);

    final response = await _repository.updateMyServiceBookingStatus(
      providerId: providerId,
      bookingId: bookingId,
      status: status,
    );

    state = state.copyWith(loadingId: "");

    response.fold(
      (failure) => showErrorSnackBar(
        context: context,
        title: failure.title,
        content: failure.message,
      ),
      (success) {
        ///Refresh My Services Bookings
        _ref.invalidate(getMyServicesBookingsFtPr);

        showSuccessSnackBar(
          context: context,
          content: success,
        );
      },
    );
  }

  //! Delete Booking
  FutureVoid deleteBooking({
    required BuildContext context,
    required String userId,
    required String bookingId,
  }) async {
    ///Assign booking Id to state so that the particular item
    ///Should show loading indicator
    state = state.copyWith(loadingId: bookingId);

    final response = await _repository.deleteBooking(
      userId: userId,
      bookingId: bookingId,
    );

    state = state.copyWith(loadingId: "");

    response.fold(
      (failure) => showErrorSnackBar(
        context: context,
        title: failure.title,
        content: failure.message,
      ),
      (success) {
        ///Refresh My Bookings
        _ref.invalidate(getMyBookingsFtPr);

        showSuccessSnackBar(
          context: context,
          content: success,
        );
      },
    );
  }
}

///Status
class _SportzHubControllerStatus {
  final String loadingId;

  _SportzHubControllerStatus({required this.loadingId});

  _SportzHubControllerStatus copyWith({
    String? loadingId,
  }) {
    return _SportzHubControllerStatus(
      loadingId: loadingId ?? this.loadingId,
    );
  }
}
