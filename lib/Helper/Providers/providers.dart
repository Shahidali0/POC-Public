// import 'package:cricket_poc/lib_exports.dart';

// ///Auth Providers

// final signupGoalErrorPr = StateProvider<String>((ref) => "");
// final signupAbouYouSelfErrorPr = StateProvider<String>((ref) => "");

// final autoSignInPr = FutureProvider<bool>((ref) async {
//   final authController = ref.read(authControllerPr.notifier);
//   return authController.autoSignIn();
// });

// ///Dahsboard Providers
// final allCategoriesPr = StateProvider<List<CategoryJson>>((ref) {
//   return [];
// });

// ///Home Providers

// final getFeaturedServicesFtPr =
//     FutureProvider.autoDispose<AllServicesJson?>((ref) async {
//   return ref.read(homeControllerPr.notifier).getFeaturedServices();
// });

// ///FindServcies Providers

// final findServicesTabBarIndexPr = StateProvider<int>((ref) => 0);

// final getFindServciesListFtPr = FutureProvider<AllServicesJson?>(
//   (ref) async {
//     final updateFilter = ref.read(filtersControllerPr).updateFilters;

//     final state = updateFilter
//         ? ref.read(filtersControllerPr)
//         : ref.read(filtersControllerPr.notifier).emptyFilter;

//     return ref
//         .read(findServicesControllerPr.notifier)
//         .findAllServices(state: state);
//   },
// );

// ///Notifications Providers

// final getNotificationCountFtPr = FutureProvider<int>(
//   (ref) async {
//     return ref
//         .read(notificationControllerPr.notifier)
//         .getUserNotificationsCount();
//   },
// );
