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

final findMyServicesPr = FutureProvider<AllServicesJson?>((ref) async {
  return ref.read(myServicesControllerPr.notifier).findMyServices();
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
  Future<AllServicesJson?> findMyServices() => _repository.findMyServices();

  //* Get User Bookings List
  Future<List<BookingsJson>> getMyBookings() => _repository.getMyBookings();
}
