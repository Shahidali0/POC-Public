part of 'package:cricket_poc/Views/Home/home_screen.dart';

///This Class shows homepage appbar with location of user and notifications icon
class _HomeTitleAppBar extends StatelessWidget {
  const _HomeTitleAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.appTheme,
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
      title: const FadeAnimations(
        child: Text(
          "GameMate",
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

///This Class shows homepage appbar with search button followed by tabs

class _HomeSearchbarWithCategories extends ConsumerWidget {
  const _HomeSearchbarWithCategories();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final currentIndex = ref.watch(_homeTabBarIndexPr);

    return SliverToBoxAdapter(
      child: Container(
        padding: Sizes.globalPadding,
        decoration: const BoxDecoration(gradient: AppColors.homeGradient),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Wish
            const Text(
              "Good evening, User",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.normal,
              ),
            ),

            ///Header
            const SizedBox(height: Sizes.spaceHeight),
            const Text(
              "Post a Task. Get it Done",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                fontSize: Sizes.fontSize22,
              ),
            ),

            ///Search Field
            const SizedBox(height: Sizes.spaceHeightSm),
            const TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: "In a few words, What do you need done?",
                prefixIcon: Icon(CupertinoIcons.search),
              ),
            ),

            ///Buttons
            const SizedBox(height: Sizes.spaceHeight * 1.5),
            CommonButton(
              onPressed: () => AppRouter.instance.animatedPush(
                context: context,
                scaleTransition: true,
                screen: const PostServiceScreen(),
              ),
              text: "Post your task for free",
              backgroundColor: AppColors.white,
              textColor: AppColors.appTheme,
            ),

            ///Categories
            const SizedBox(height: Sizes.spaceHeight * 2),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: Sizes.space),
                itemBuilder: (BuildContext context, int index) {
                  return ActionChip.elevated(
                    onPressed: () {},
                    padding: Sizes.globalPadding,
                    label: Text("Category:${index + 1}"),
                  );
                },
              ),
            ),

            const SizedBox(height: Sizes.spaceHeight),
          ],
        ),
      ),
    );
  }
}
