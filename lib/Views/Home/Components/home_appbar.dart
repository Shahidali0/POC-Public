part of 'package:cricket_poc/Views/Home/home_screen.dart';

///This Class shows homepage appbar with location of user and notifications icon
class _HomeTitleAppBar extends StatelessWidget {
  const _HomeTitleAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleSpacing: 0,
      leadingWidth: 0,
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
        ref.watch(homeControllerPr.notifier).getAllCategoriesList;

    final user = ref.watch(userJsonPr)?.user;

    return SliverToBoxAdapter(
      child: Container(
        padding: Sizes.globalPadding,
        decoration: const BoxDecoration(gradient: AppColors.homeGradient),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Sizes.spaceHeightSm),

            ///User Wish
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.normal,
                    ),
                text: user != null ? "Welcome back, " : "Welcome, ",
                children: [
                  ///UserName
                  if (user != null)
                    TextSpan(
                      text: "${user.firstName} ${user.lastName}",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                    ),
                ],
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
                hintText: "Search for coaching, training or services…",
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
                    onPressed: () =>
                        ref.read(homeControllerPr.notifier).onTapCategory(
                              context: context,
                              sport: item.sport!,
                              category: item.category!,
                            ),
                    padding: Sizes.globalPadding,
                    label: Text(item.category!),
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
