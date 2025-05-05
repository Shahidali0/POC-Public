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
      body: LazyLoadIndexedStack(
        index: currentIndex,
        preloadIndexes: const [0],
        children: const [
          HomeScreen(key: PageStorageKey("Homescreen")),
          FindServicesScreen(key: PageStorageKey("FindServicesScreen")),

          ///This is For PostButton(+)
          SizedBox.shrink(),

          SportzHubScreen(key: PageStorageKey("MyServicesScreen")),
          ProfileScreen(key: PageStorageKey("ProfileScreen")),
        ],
      ),
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
    final selectedIndex = ref.watch(_navBarIndexPr);

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.border, width: 2),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) =>
            ref.read(navbarControllerPr.notifier).onTapBottomNavBarItem(
                  context: context,
                  index: index,
                ),
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

          ///SportZHub

          const BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            // icon: Icon(Icons.design_services_outlined),
            activeIcon: Icon(CupertinoIcons.settings_solid),
            label: "SportZHub",
          ),

          ///Profile
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            activeIcon: Icon(CupertinoIcons.person_fill),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
