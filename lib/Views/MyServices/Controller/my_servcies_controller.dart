import 'package:cricket_poc/lib_exports.dart';

final myServicesControllerPr =
    StateNotifierProvider<MyServciesController, bool>(
  (ref) => MyServciesController(
    myServiceRepo: ref.read(myServicesRepositoryPr),
  ),
);

final myServicesTabBarIndexPr = StateProvider<int>((ref) => 0);

final myBookingSegemntIndexPr = StateProvider<MyBookingType>(
  (ref) => MyBookingType.upcoming,
);

final getMyServicesListPr = FutureProvider<AllServicesJson?>((ref) async {
  return ref.read(myServicesControllerPr.notifier).getMyServicesList();
});

final getMyBookingsPr = FutureProvider<List<BookingsJson>>((ref) async {
  return ref.read(myServicesControllerPr.notifier).getMyBookings();
});

class MyServciesController extends StateNotifier<bool> {
  final MyServicesRepository _repository;

  MyServciesController({
    required MyServicesRepository myServiceRepo,
  })  : _repository = myServiceRepo,
        super(false);

  //* Find My Services
  Future<AllServicesJson?> getMyServicesList() =>
      _repository.getMyServicesList();

  //* Get User Bookings List
  Future<List<BookingsJson>> getMyBookings() => _repository.getMyBookings();
}
