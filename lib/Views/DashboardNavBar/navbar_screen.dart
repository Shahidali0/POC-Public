import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

part "Controller/navbar_controller.dart";

class NavbarScreen extends ConsumerWidget {
  const NavbarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(_navBarIndexPr);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          HomeScreen(key: PageStorageKey("Homescreen")),
          FindServicesScreen(key: PageStorageKey("FindServicesScreen")),

          ///This is For PostButton(+)
          SizedBox.shrink(),

          MyServicesScreen(key: PageStorageKey("MyServicesScreen")),
          ProfileScreen(key: PageStorageKey("ProfileScreen")),
        ],
      ),
      bottomNavigationBar: _CustomNavigationBar(ref: ref),
    );
  }

  // ///OnNotification Update
  // bool _onNotification({
  //   required UserScrollNotification notification,
  //   required bool showNavbar,
  //   required WidgetRef ref,
  // }) {
  //   if (notification.direction == ScrollDirection.forward) {
  //     ///Show Bottom NavBar
  //     if (!showNavbar) {
  //       ref.read(_showOrHideNavBarPr.notifier).update((st) => st = true);
  //     }
  //   } else if (notification.direction == ScrollDirection.reverse) {
  //     ///Hide Bottom NavBar
  //     if (showNavbar) {
  //       ref.read(_showOrHideNavBarPr.notifier).update((st) => st = false);
  //     }
  //   } else if (notification.direction == ScrollDirection.idle) {
  //     ///Show Bottom NavBar
  //     Future.delayed(
  //       const Duration(seconds: 1, milliseconds: 500),
  //       () {
  //         if (!showNavbar) {
  //           ref.read(_showOrHideNavBarPr.notifier).update((st) => st = true);
  //         }
  //       },
  //     );
  //   }
  //   return true;
  // }
}

///This Class shows Custom Bottom Navigation bar
class _CustomNavigationBar extends StatelessWidget {
  const _CustomNavigationBar({
    required this.ref,
  });
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(_navBarIndexPr);

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.border, width: 2),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          ///This is for Post Service Buttton
          if (index == 2) {
            AppRouter.instance.animatedPush(
              context: context,
              scaleTransition: true,
              screen: const PostServiceScreen(),
            );
          }

          ///For Other Icons
          else {
            ref
                .read(navbarControllerPr.notifier)
                .updateNavbarIndex(index: index);
          }
        },
        items: [
          ///Home
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            activeIcon: Icon(CupertinoIcons.house_fill),
            label: "Home",
          ),

          ///Find Services
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.doc_text_search),
            activeIcon: Icon(CupertinoIcons.search),
            label: "Services",
          ),

          ///Post Services
          BottomNavigationBarItem(
            icon: Transform.scale(
              scale: 1.47,
              child: const Icon(
                CupertinoIcons.add_circled_solid,
                size: 35,
              ),
            ),
            label: "",
          ),

          ///My Services
          const BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            // icon: Icon(Icons.design_services_outlined),
            activeIcon: Icon(CupertinoIcons.settings_solid),
            label: "My Services",
          ),

          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            activeIcon: Icon(CupertinoIcons.person_circle_fill),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}


///  return Material(
      // child: StatefulBuilder(
      //   builder =
      //       (BuildContext context, void Function(void Function()) setState) {
      //     print("StatefulBuilder");
      //     return FutureBuilder<List<CategoryJson>>(
      //       future: ref.watch(navbarControllerPr.notifier).loadData(),
      //       builder: (BuildContext context,
      //           AsyncSnapshot<List<CategoryJson>> snapshot) {
      //         switch (snapshot.connectionState) {
      //           case ConnectionState.waiting:
      //             return const ShowDataLoader();
      //           case ConnectionState.done:
      //           default:
      //             //*If SnapData has error
      //             if (snapshot.hasError) {
      //               final error = snapshot.error as Failure;\
      //               return ErrorText(
      //                 title: error.title,
      //                 error: error.message,
      //                 onRefresh: () async => setState(() {}),
      //               );
      //             }
      //             //*If SnapData is present
      //             else if (snapshot.hasData) {
      //               return _bodyView(
      //                 ref: ref,
      //                 currentIndex: currentIndex,
      //               );
      //             }
      //             //*If No Data Available
      //             else {
      //               return const EmptyDataWidget();
      //             }
      //         }
      //       },
      //     );
      //   },
      // ),
      // child: ref.watch(_getAllCategoriesListPr).when(
      //       data: (data) {
      //         if (data.isEmpty) {
      //           return const EmptyDataWidget();
      //         }

      //         return _bodyView(
      //           ref: ref,
      //           currentIndex: currentIndex,
      //         );
      //       },
      //       error: (e, st) {
      //         final error = e as Failure;
      //         return ErrorText(
      //           title: error.title,
      //           error: error.message,
      //           onRefresh: () async => ref.invalidate(_getAllCategoriesListPr),
      //         );
      //       },
      //       loading: () => const ShowDataLoader(),
      //     ),
    // );
 