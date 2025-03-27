part of 'package:cricket_poc/Views/Home/home_screen.dart';

///This Class shows homepage appbar with location of user and notifications icon
class _HomeTitleAppBar extends StatelessWidget {
  const _HomeTitleAppBar();

  @override
  Widget build(BuildContext context) {
    const bottomHeight = kToolbarHeight + Sizes.space;

    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 145,

      scrolledUnderElevation: 0,
      // flexibleSpace: const FlexibleSpaceBar(
      //   collapseMode: CollapseMode.parallax,
      //   background: DecoratedBox(
      //     decoration: BoxDecoration(gradient: AppColors.homeGradient),
      //   ),
      // ),
      flexibleSpace: const DecoratedBox(
        decoration: BoxDecoration(gradient: AppColors.homeGradient),
        child: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
        ),
      ),
      actions: [
        FadeAnimations(
          child: Padding(
            padding: const EdgeInsets.only(right: Sizes.space),
            child: CommonIconButton(
              onPressed: () => AppRouter.instance.push(
                context: context,
                screen: const NotificationScreen(),
              ),
              iconData: CupertinoIcons.bell,
              iconColor: AppColors.white,
            ),
          ),
        )
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(bottomHeight),
        child: FadeAnimations(
          child: Padding(
            padding: EdgeInsets.only(
              left: Sizes.space,
              right: Sizes.space,
              bottom: Sizes.space,
            ),
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(CupertinoIcons.search),
              ),
            ),
          ),
        ),
      ),
      title: FadeAnimations(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            GestureDetector(
              onTap: () {
                debugPrint("MY LIOCATION");
              },
              child: Row(
                children: [
                  Text(
                    "My Location",
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                      fontSize: Sizes.defaultSize,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.white.withOpacity(0.7),
                  ),
                ],
              ),
            ),

            ///Location ---User
            const Text(
              "Pietersburg,ST",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: Sizes.fontSize18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///This Class shows homepage appbar with search button followed by tabs

class HomeSearchbarWithTabs extends ConsumerWidget {
  const HomeSearchbarWithTabs({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homeTabBarIndexPr);

    return SliverAppBar(
      pinned: true,
      primary: false,
      toolbarHeight: 90,
      expandedHeight: 90,
      scrolledUnderElevation: 2,
      titleSpacing: 0,
      surfaceTintColor: AppColors.white,
      title: TabBar(
        controller: tabController,
        isScrollable: true,
        onTap: (index) =>
            ref.read(homeTabBarIndexPr.notifier).update((st) => st = index),
        tabAlignment: TabAlignment.start,
        labelPadding: const EdgeInsets.all(Sizes.space),
        padding: const EdgeInsets.only(bottom: 8.0),
        tabs: List.generate(
          homeTabbarItemsData.length,
          (index) => FadeAnimations(
            child: Tab(
              text: homeTabbarItemsData[index].title,
              icon: CircleAvatar(
                backgroundColor: AppColors.white,
                radius: 25,
                child: Icon(
                  homeTabbarItemsData[index].iconData,
                  color: currentIndex == index
                      ? AppColors.appTheme
                      : AppColors.blueGrey,
                ),
              ),
            ),
          ),
        ),
      ),
      flexibleSpace: const FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: DecoratedBox(
          decoration: BoxDecoration(gradient: AppColors.homeGradient2),
        ),
      ),
    );
  }
}






// class HomeSearchbarWithTabs extends SliverPersistentHeaderDelegate {
//   HomeSearchbarWithTabs({required this.tabController});

//   final TabController tabController;

//   double get _maxHeight => 110;
//   double get _minHeight => 90;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     final opacity = 1 - (shrinkOffset / _maxHeight);
//     print("opacity:$opacity");
//     return Card(
//       margin: EdgeInsets.zero,
//       color: AppColors.white,
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           ///Gradient
//           AnimatedOpacity(
//             duration: Sizes.durationS,
//             opacity: opacity < 1 ? 0 : opacity,
//             child: const DecoratedBox(
//               decoration: BoxDecoration(gradient: AppColors.homeGradient2),
//             ),
//           ),

//           ///Tabbar
//           Consumer(
//             builder: (_, WidgetRef ref, __) {
//               final currentIndex = ref.watch(homeTabBarIndexPr);
//               return TabBar(
//                 controller: tabController,
//                 isScrollable: true,
//                 onTap: (index) => ref
//                     .read(homeTabBarIndexPr.notifier)
//                     .update((st) => st = index),
//                 tabAlignment: TabAlignment.start,
//                 indicator: const BoxDecoration(color: AppColors.transparent),
//                 labelPadding: const EdgeInsets.symmetric(horizontal: 20),
//                 padding: const EdgeInsets.only(bottom: 8.0),
//                 tabs: List.generate(
//                   2,
//                   (index) => Tab(
//                     text: "Home",
//                     icon: CircleAvatar(
//                       backgroundColor: AppColors.white,
//                       radius: 24,
//                       child: Icon(
//                         Icons.home,
//                         color: currentIndex == index
//                             ? AppColors.appTheme
//                             : AppColors.grey,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   double get maxExtent => _maxHeight;

//   @override
//   double get minExtent => _minHeight;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
//       false;
// }
