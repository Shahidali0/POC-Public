import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class IntroScreen extends ConsumerStatefulWidget {
  const IntroScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(introIndexPr);
    return Scaffold(
      appBar: AppBar(
        actions: [
          CommonTextButton(
            onPressed: () => ref
                .read(introControllerPr.notifier)
                .onTapSkip(context: context),
            text: "Skip",
            decoration: TextDecoration.underline,
          ),
        ],
      ),
      body: SafeArea(
        minimum: Sizes.globalMargin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _IntroPages(
                pageController: _pageController,
                ref: ref,
              ),
            ),

            ///Dot Indicator
            const SizedBox(height: Sizes.space),
            DotIndicator(
              count: 3,
              currentIndex: currentIndex,
            ),
            const SizedBox(height: Sizes.space * 4),

            ///Next Button
            CommonButton(
              minButtonWidth: 200,
              onPressed: () => ref.read(introControllerPr.notifier).onTapNext(
                    context: context,
                    pageController: _pageController,
                    currentIndex: currentIndex,
                  ),
              text: currentIndex == 2 ? "Continue" : "Next",
            ),
          ],
        ),
      ),
    );
  }
}

///Intro Pages
class _IntroPages extends StatelessWidget {
  const _IntroPages({
    required this.pageController,
    required this.ref,
  });

  final PageController pageController;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: (int value) {
        ref.read(introIndexPr.notifier).state = value;
      },
      children: const [
        ///Intro1
        _IntroWidget(
          image: AppImages.intro1,
          heading: "Find Services",
          description:
              "Browse through our verified game services and select what you need",
        ),

        ///Intro2
        _IntroWidget(
          image: AppImages.intro2,
          heading: "Book Time Slot",
          description:
              "Choose your preferred date and time slot for the service",
        ),

        ///Intro3
        _IntroWidget(
          image: AppImages.intro3,
          heading: "Enjoy Quality Service",
          description:
              "Experience professional game services from verified providers",
        ),
      ],
    );
  }
}

///* Intro Widget
class _IntroWidget extends StatelessWidget {
  const _IntroWidget({
    required this.image,
    required this.heading,
    required this.description,
  });

  final String image;
  final String heading;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ///Image
        FadeAnimations(
          from: 80,
          delay: 3.2,
          type: MyAnimationType.rightToLeft,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.borderRadius),
            child: Image.asset(
              image,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: Sizes.spaceHeight),

        ///Header
        FadeAnimations(
          from: 80,
          delay: 3.2,
          type: MyAnimationType.rightToLeft,
          child: Text(
            heading,
            style: const TextStyle(
              fontSize: Sizes.fontSize24,
              fontWeight: FontWeight.w800,
              color: AppColors.appTheme,
            ),
          ),
        ),
        const SizedBox(height: Sizes.spaceSmall),

        ///Description
        FadeAnimations(
          from: 80,
          delay: 3.2,
          type: MyAnimationType.rightToLeft,
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: Sizes.fontSize18,
              fontWeight: FontWeight.normal,
              color: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
