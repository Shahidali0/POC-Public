import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

part "Controller/navbar_controller.dart";

class DashboardNavbarScreen extends ConsumerWidget {
  const DashboardNavbarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(_navBarIndexPr);
    final showNavbar = ref.watch(_showOrHideNavBarPr);

    return Material(
      child: ref.watch(_getAllCategoriesListPr).when(
            skipLoadingOnRefresh: false,
            data: (data) {
              if (data.isEmpty) {
                return const EmptyDataWidget();
              }

              return _bodyView(
                showNavbar: showNavbar,
                ref: ref,
                currentIndex: currentIndex,
              );
            },
            error: (e, st) {
              final error = e as Failure;
              return ErrorText(
                title: error.title,
                error: error.message,
                onRefresh: () async => ref.invalidate(_getAllCategoriesListPr),
              );
            },
            loading: () => const ShowDataLoader(),
          ),
    );
  }

  ///BodyView
  Widget _bodyView({
    required bool showNavbar,
    required WidgetRef ref,
    required int currentIndex,
  }) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          HomeScreen(),
          FindServicesScreen(),

          ///This is PostButton(+)
          SizedBox(),

          MyServicesScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: AnimatedCrossFade(
        duration: Sizes.duration,
        firstChild: _CustomNavigationBar(ref: ref),
        secondChild: const SizedBox.shrink(),
        crossFadeState:
            showNavbar ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
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

//  return Padding(
//     padding:
//         const EdgeInsets.fromLTRB(Sizes.space, 0, Sizes.space, Sizes.space),
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(Sizes.borderRadius * 2),
//       child: NavigationBarTheme(
//         data: Theme.of(context).navigationBarTheme.copyWith(

//             ///This is for Custom Label Style
//             // labelTextStyle: WidgetStateProperty.resolveWith(
//             //   (state) {
//             //     if (state.contains(WidgetState.selected)) {
//             //       return TextStyle(
//             //         color: AppColors.indicatorColors[selectedIndex],
//             //         fontStyle: FontStyle.italic,
//             //         fontWeight: FontWeight.w600,
//             //         fontSize: Sizes.fontSize12,
//             //       );
//             //     }
//             //     return const TextStyle(
//             //       color: AppColors.black,
//             //     );
//             //   },
//             // ),

//             ),
//         child: NavigationBar(
//           backgroundColor: AppColors.transparent,
//           selectedIndex: selectedIndex,
//           onDestinationSelected: (value) =>
//               ref.read(navBarIndexPr.notifier).update((st) => st = value),
//           // indicatorColor: AppColors.indicatorColors[selectedIndex],
//           destinations: const [
//             ///Home
//             NavigationDestination(
//               icon: Icon(CupertinoIcons.home),
//               selectedIcon: Icon(CupertinoIcons.house_fill),
//               label: "Home",
//             ),

//             ///Find Services
//             Padding(
//               padding: EdgeInsets.only(right: 5),
//               child: NavigationDestination(
//                 icon: Icon(CupertinoIcons.doc_text_search),
//                 selectedIcon: Icon(CupertinoIcons.search),
//                 label: "Find Services",
//               ),
//             ),

//             ///My Services
//             Padding(
//               padding: EdgeInsets.only(left: 5),
//               child: NavigationDestination(
//                 icon: Icon(Icons.design_services_outlined),
//                 selectedIcon: Icon(CupertinoIcons.settings_solid),
//                 label: "My Services",
//               ),
//             ),

//             ///Profile
//             NavigationDestination(
//               icon: Icon(CupertinoIcons.person),
//               selectedIcon: Icon(CupertinoIcons.person_fill),
//               label: "Profile",
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
