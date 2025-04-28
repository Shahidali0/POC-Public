import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

final sportzHubControllerPr = StateNotifierProvider<SportzHubController, bool>(
  (ref) => SportzHubController(
    sportzHubRepo: ref.read(sportzHubRepositoryPr),
  ),
);

final myServicesTabBarIndexPr = StateProvider<int>((ref) => 0);

final myBookingSegemntIndexPr = StateProvider<MyBookingType>(
  (ref) => MyBookingType.upcoming,
);

final getMyServicesListPr = FutureProvider<AllServicesJson?>((ref) async {
  return ref.read(sportzHubControllerPr.notifier).getMyServicesList();
});

final getMyBookingsPr = FutureProvider<List<BookingsJson>>((ref) async {
  return ref.read(sportzHubControllerPr.notifier).getMyBookings();
});

class SportzHubController extends StateNotifier<bool> {
  final SportzHubRepository _repository;

  SportzHubController({
    required SportzHubRepository sportzHubRepo,
  })  : _repository = sportzHubRepo,
        super(false);

  //* Find My Services
  Future<AllServicesJson?> getMyServicesList() =>
      _repository.getMyServicesList();

  //* Get User Bookings List
  Future<List<BookingsJson>> getMyBookings() => _repository.getMyBookings();

  //! Delete Booking
  FutureVoid deleteBooking({required BuildContext context}) async {}
}
