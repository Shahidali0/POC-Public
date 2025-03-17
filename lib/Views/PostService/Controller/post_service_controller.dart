part of 'package:cricket_poc/Views/PostService/post_service_screen.dart';

final postServiceControllerPr =
    StateNotifierProvider<_PostServiceController, bool>(
  (ref) => _PostServiceController(),
);

final _stepperIndexPr = StateProvider<int>((ref) => 0);

class _PostServiceController extends StateNotifier<bool> {
  _PostServiceController() : super(false);

  ///FormKeys
  GlobalKey<FormState> serviceDetailsFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> locationScheduleFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> pricingFormKey = GlobalKey<FormState>();

  ///Handle Service Details Page Validations
  void handleServiceDetailsValidation() {}

  ///Handle Location Schedule Page Validations
  void handleLocationScheduleValidation() {}

  ///Handle Pricing Page Validations
  void handlePricingValidation() {}

  //################################### ############################
  //################################### ############################
}
