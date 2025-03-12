import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardNavbarScreen extends ConsumerWidget {
  const DashboardNavbarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navBarIndexPr);
    return Scaffold(
      // body: AnimatedSwitcher(
      //   key: Key("$currentIndex"),
      //   duration: Sizes.duration,
      //   child: IndexedStack(
      //     index: currentIndex,
      //     children: const [
      //       HomeScreen(),
      //       FindServicesScreen(),
      //       MyServicesScreen(),
      //       ProfileScreen(),
      //     ],
      //   ),
      // ),

      body: IndexedStack(
        index: currentIndex,
        children: const [
          HomeScreen(),
          FindServicesScreen(),
          MyServicesScreen(),
          ProfileScreen(),
        ],
      ),
      floatingActionButton: SafeArea(
        child: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: _CustomNavigationBar(ref: ref),
    );
  }
}

///This Class shows Custom Bottom Navigation bar
class _CustomNavigationBar extends StatelessWidget {
  const _CustomNavigationBar({
    required this.ref,
  });
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(navBarIndexPr);

    return SafeArea(
      minimum:
          const EdgeInsets.fromLTRB(Sizes.space, 0, Sizes.space, Sizes.space),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Sizes.borderRadius * 2),
        child: NavigationBarTheme(
          data: Theme.of(context).navigationBarTheme.copyWith(
            ///This is for Custom Label Style
            labelTextStyle: WidgetStateProperty.resolveWith(
              (state) {
                if (state.contains(WidgetState.selected)) {
                  return TextStyle(
                    color: AppColors.indicatorColors[selectedIndex],
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.fontSize12,
                  );
                }
                return const TextStyle(
                  color: AppColors.black,
                );
              },
            ),
          ),
          child: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) =>
                ref.read(navBarIndexPr.notifier).update((st) => st = value),
            indicatorColor: AppColors.indicatorColors[selectedIndex],
            destinations: const [
              ///Home
              NavigationDestination(
                icon: Icon(CupertinoIcons.home),
                selectedIcon: Icon(CupertinoIcons.house_fill),
                label: "Home",
              ),

              ///Find Services
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: NavigationDestination(
                  icon: Icon(CupertinoIcons.doc_text_search),
                  selectedIcon: Icon(CupertinoIcons.search),
                  label: "Find Services",
                ),
              ),

              ///My Services
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: NavigationDestination(
                  icon: Icon(Icons.design_services_outlined),
                  selectedIcon: Icon(CupertinoIcons.settings_solid),
                  label: "My Services",
                ),
              ),

              ///Profile
              NavigationDestination(
                icon: Icon(CupertinoIcons.person),
                selectedIcon: Icon(CupertinoIcons.person_fill),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
