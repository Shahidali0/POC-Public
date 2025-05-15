import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SportzHubScreen extends ConsumerStatefulWidget {
  const SportzHubScreen({super.key});

  @override
  ConsumerState<SportzHubScreen> createState() => _SportzHubScreenState();
}

class _SportzHubScreenState extends ConsumerState<SportzHubScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newIndex = ref.watch(sportzHubTabIndexPr);
      if (_tabController.index != newIndex) {
        _tabController.animateTo(newIndex);
        ref.invalidate(sportzHubTabIndexPr);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoAppbar(
        title: "SportZHub",
        showNotificationIcon: true,
      ),
      child: NestedScrollView(
        floatHeaderSlivers: true,
        physics: const ClampingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            ///Appbar
            SliverAppBar(
              toolbarHeight: 0,
              floating: true,
              snap: true,
              surfaceTintColor: AppColors.transparent,
              bottom: TabBar(
                controller: _tabController,
                labelColor: AppColors.appTheme,
                indicatorColor: AppColors.appTheme,
                padding: const EdgeInsets.symmetric(horizontal: Sizes.space),
                tabs: [
                  "My Services",
                  "My Bookings",
                ]
                    .map(
                      (text) => Tab(text: text),
                    )
                    .toList(),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: const [
            MyServicesTabviewPage(),
            MyBookingsTabviewPage(),
          ],
        ),
      ),
    );
  }
}
