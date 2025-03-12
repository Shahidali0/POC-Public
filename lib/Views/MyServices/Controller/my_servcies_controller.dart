import 'package:cricket_poc/lib_exports.dart';

final myServicesControllerPr =
    StateNotifierProvider<MyServciesController, bool>(
        (ref) => MyServciesController());

final myServicesTabBarIndexPr = StateProvider<int>((ref) => 0);

final myBookingSegemntIndexPr = StateProvider<MyBookingType>(
  (ref) => MyBookingType.upcoming,
);

class MyServciesController extends StateNotifier<bool> {
  MyServciesController() : super(false);
}
