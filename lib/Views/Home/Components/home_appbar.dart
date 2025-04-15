part of 'package:cricket_poc/Views/Home/home_screen.dart';

///This Class shows homepage appbar with location of user and notifications icon
class _HomeTitleAppBar extends StatelessWidget {
  const _HomeTitleAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.blueLight,
      actions: [
        FadeAnimations(
          child: Padding(
            padding: const EdgeInsets.only(right: Sizes.spaceMed),
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
      title: FadeAnimations(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ///App Logo Header
            Image.asset(
              AppImages.logoTitle,
              color: AppColors.white,
              width: Sizes.screenWidth(context) * 0.6,
            ),

            ///Running Logo
            Positioned(
              left: -40,
              top: -10,
              bottom: 0,
              child: Image.asset(
                AppImages.logoHeader,
                fit: BoxFit.fitHeight,
                filterQuality: FilterQuality.high,
              ),
            ),
          ],
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
    final categories =
        ref.watch(homeControllerPr.notifier).getAllCattegoriesList;

    final user = ref.watch(userJsonPr)?.user;

    return SliverToBoxAdapter(
      child: Container(
        padding: Sizes.globalPadding,
        decoration: const BoxDecoration(gradient: AppColors.homeGradient),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Sizes.spaceHeightSm),

            ///Wish
            Text(
              user == null
                  ? "Good evening"
                  : "Good evening, ${user.firstName} ${user.lastName}",
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.normal,
              ),
            ),

            ///Header
            const SizedBox(height: Sizes.spaceHeightSm),
            const Text(
              "Discover. Book. Get SportZReady",
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
            const SizedBox(height: Sizes.spaceHeight),
            CommonButton(
              onPressed: () => AppRouter.instance.animatedPush(
                context: context,
                scaleTransition: true,
                screen: const PostServiceScreen(),
              ),
              text: "Post Your Service for free",
              backgroundColor: AppColors.white,
              textColor: AppColors.appTheme,
            ),

            ///Categories
            const SizedBox(height: Sizes.spaceHeight * 1.4),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: Sizes.space),
                itemBuilder: (BuildContext context, int index) {
                  final item = categories[index];
                  return ActionChip.elevated(
                    onPressed: () {},
                    padding: Sizes.globalPadding,
                    label: Text(item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
