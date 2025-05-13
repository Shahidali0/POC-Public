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
      // scrolledUnderElevation: 0,
      backgroundColor: AppColors.appTheme,
      actions: const [
        FadeAnimations(
          child: Padding(
            padding: EdgeInsets.only(right: Sizes.spaceMed),
            child: NotificationIcon(iconColor: AppColors.white),
          ),
        )
      ],
      title: FadeAnimations(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ///App Logo Header
            Image.asset(
              AppImages.logoText,
              color: AppColors.white,
              width: Sizes.screenWidth(context) * 0.6,
            ),

            ///Running Logo
            Positioned(
              left: -40,
              top: -5,
              bottom: 0,
              child: Image.asset(
                AppImages.personRunningLogo,
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
            const SizedBox(height: Sizes.spaceHeight),

            /// WishUser
            _buildWishUser(
              context: context,
              user: user,
            ),

            ///Header
            Text(
              "Discover. Book. Get SportZReady",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.tag,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppTheme.boldFont,
                    fontStyle: FontStyle.italic,
                  ),
            ),

            ///Search Field
            const SizedBox(height: Sizes.spaceHeight * 1.2),
            _buildSearchField(
              ref: ref,
              context: context,
            ),

            ///Categories
            const SizedBox(height: Sizes.spaceHeight * 1.4),
            const HomeHeaderText(title: "Top Categories"),
            const SizedBox(height: Sizes.space),

            _buildCategories(categories, ref),

            ///Content
            const SizedBox(height: Sizes.spaceHeight * 1.2),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  ///Wish User
  Widget _buildWishUser({
    required BuildContext context,
    required UserJson? user,
  }) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.normal,
              fontSize: Sizes.fontSize18,
            ),
        text: user != null ? "Hey " : "Hey, ",
        children: [
          ///UserName
          if (user != null)
            TextSpan(
              text: "${user.firstName}, ",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                    fontSize: Sizes.fontSize20,
                    fontFamily: AppTheme.boldFont,
                  ),
            ),
          TextSpan(
            text: "Let’s Get You SportZReady!",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: Sizes.fontSize18,
                ),
          ),
        ],
      ),
    );
  }

  ///Search Field
  Widget _buildSearchField({
    required WidgetRef ref,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () => ref
          .read(homeControllerPr.notifier)
          .showSearchWidget(context: context),
      child: Container(
        padding: Sizes.globalPadding * 0.7,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(Sizes.borderRadius),
        ),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.search,
              color: AppColors.grey,
            ),
            const SizedBox(width: Sizes.space),

            ///Search Text
            Flexible(
              child: Text(
                "Search coaching, training, or services near you...",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.blueGrey,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Categories
  Widget _buildCategories(List<CategoryJson> categories, WidgetRef ref) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: Sizes.space),
        itemBuilder: (BuildContext context, int index) {
          final item = categories[index];

          return ActionChip.elevated(
            onPressed: () => ref.read(homeControllerPr.notifier).onTapCategory(
                  context: context,
                  sport: item.sport,
                  category: item.category,
                ),
            padding: Sizes.globalPadding,
            label: Text(item.category!),
          );
        },
      ),
    );
  }

  ///Content Widget
  Widget _buildContent(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.blueGrey,
              fontFamily: AppTheme.regularFont,
            ),
        text:
            "Your next booking starts with one click. Add your service and get SportZReady! ",
        children: [
          ///Clickable Text
          TextSpan(
            text: "Post Service",
            recognizer: TapGestureRecognizer()
              ..onTap = () => AppRouter.instance.animatedPush(
                    context: context,
                    page: const PostServiceScreen(),
                  ),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.orange,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppTheme.boldFont,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.orange,
                  decorationThickness: 2,
                  decorationStyle: TextDecorationStyle.solid,
                ),
          ),
        ],
      ),
    );
  }
}
