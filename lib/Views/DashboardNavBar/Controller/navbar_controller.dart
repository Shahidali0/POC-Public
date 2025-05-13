part of 'package:cricket_poc/Views/DashboardNavBar/navbar_screen.dart';

final _navBarIndexPr = StateProvider<int>((ref) => 0);

final allCategoriesPr = StateProvider<List<CategoryJson>>((ref) {
  return [];
});

final navbarControllerPr = StateNotifierProvider<NavbarController, bool>(
  (ref) => NavbarController(
    navBarRepository: ref.read(navbarRepositoryPr),
    profileRepository: ref.read(profileRepositoryPr),
    ref: ref,
  ),
);

class NavbarController extends StateNotifier<bool> {
  final NavBarRepository _navBarRepository;
  final ProfileRepository _profileRepository;
  final Ref _ref;

  NavbarController({
    required NavBarRepository navBarRepository,
    required ProfileRepository profileRepository,
    required Ref ref,
  })  : _navBarRepository = navBarRepository,
        _profileRepository = profileRepository,
        _ref = ref,
        super(false);

  @override
  dispose() {
    _ref.invalidate(_navBarIndexPr);
    super.dispose();
  }

  ///Update Navbar Index
  void updateNavbarIndex({required int index}) {
    _ref.read(_navBarIndexPr.notifier).update((st) => st = index);
  }

  ///OnTap Bottom NavBar Item
  void onTapBottomNavBarItem({
    required BuildContext context,
    required int index,
  }) {
    _ref.invalidate(getNotificationCountFtPr);

    ///This is for Post Service Buttton
    if (index == 2) {
      ///Check If User Authorized or not
      _ref.read(profileControllerPr.notifier).isAuthorized(
            context: context,
            redirectTo: () async => AppRouter.instance.animatedPush(
              context: context,
              scaleTransition: true,
              page: const PostServiceScreen(),
            ),
          );
      return;
    }

    /// For My Services and Profile Check for Authorization
    if (index == 3 || index == 4) {
      _ref.read(profileControllerPr.notifier).isAuthorized(
            context: context,
            redirectTo: () => updateNavbarIndex(index: index),
          );
      return;
    }

    ///For Home and Find Services no need Authorization
    else {
      updateNavbarIndex(index: index);
    }
  }

  ///Load all required api's
  Future<List<CategoryJson>> loadDashboardData() async {
    // print("Load Data");
    // throw AppExceptions.instance.handleSocketException();

    final response = await Future.wait([
      _navBarRepository.getAllCategories(),
      _profileRepository.getCurrentUser(),
    ]);

    //* Update Categories List
    _ref
        .read(allCategoriesPr.notifier)
        .update((state) => state = response[0] as List<CategoryJson>);

    return response[0] as List<CategoryJson>;
  }

  ///Get all Categories
  Future<List<CategoryJson>> getAllCategories() async {
    final categories = await _navBarRepository.getAllCategories();

    _ref.read(allCategoriesPr.notifier).update((state) => state = categories);

    return categories;
  }
}
