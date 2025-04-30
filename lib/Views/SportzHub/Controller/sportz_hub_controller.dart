import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

final sportzHubControllerPr =
    StateNotifierProvider<SportzHubController, String?>(
  (ref) => SportzHubController(
    ref: ref,
    sportzHubRepo: ref.read(sportzHubRepositoryPr),
  ),
);

final myBookingSegemntIndexPr = StateProvider<MyBookingType>(
  (ref) => MyBookingType.upcoming,
);

final getMyServicesListPr = FutureProvider<AllServicesJson?>((ref) async {
  return ref.read(sportzHubControllerPr.notifier).getMyServicesList();
});

final getMyBookingsPr = FutureProvider<List<BookingsJson>>((ref) async {
  return ref.read(sportzHubControllerPr.notifier).getMyBookings();
});

class SportzHubController extends StateNotifier<String?> {
  final SportzHubRepository _repository;
  final Ref _ref;

  SportzHubController({
    required SportzHubRepository sportzHubRepo,
    required Ref ref,
  })  : _repository = sportzHubRepo,
        _ref = ref,
        super(null);

  Color getStatusColor(String text) {
    switch (text.toLowerCase()) {
      case "pending":
        return AppColors.orange;

      case "canceled":
        return AppColors.red;

      case "completed":
        return AppColors.green;

      default:
        return AppColors.black;
    }
  }

  //* Find My Services
  Future<AllServicesJson?> getMyServicesList() =>
      _repository.getMyServicesList();

  //* Get User Bookings List
  Future<List<BookingsJson>> getMyBookings() => _repository.getMyBookings();

  //! Delete Booking
  FutureVoid deleteBooking({
    required BuildContext context,
    required String userId,
    required String bookingId,
  }) async {
    ///Assign booking Id to state so that the particular item
    ///Show show loading indicator
    state = bookingId;

    final response = await _repository.deleteBooking(
      userId: userId,
      bookingId: bookingId,
    );

    state = null;

    response.fold(
      (failure) => showErrorSnackBar(
        context: context,
        title: failure.title,
        content: failure.message,
      ),
      (success) {
        ///Refresh My Bookings
        _ref.invalidate(getMyBookingsPr);

        showSuccessSnackBar(
          context: context,
          content: success,
        );
      },
    );
  }
}
