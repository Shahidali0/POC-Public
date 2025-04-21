import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  late Future<List<CategoryJson>> _futureData;

  @override
  void initState() {
    _futureData = ref.read(navbarControllerPr.notifier).loadDashboardData();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  ///Refresh Data
  void _refreshData() {
    setState(() {
      _futureData = ref.read(navbarControllerPr.notifier).loadDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder<List<CategoryJson>>(
        future: _futureData,
        builder:
            (BuildContext context, AsyncSnapshot<List<CategoryJson>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const ShowDataLoader();

            case ConnectionState.done:
            default:
              //*If SnapData has error
              if (snapshot.hasError) {
                final error = snapshot.error as Failure;

                return ErrorText(
                  title: error.title,
                  error: error.message,
                  onRefresh: _refreshData,
                );
              }
              //*If SnapData is present
              else if (snapshot.hasData) {
                ///If Data is Available then go to Navbar Screen
                Future.microtask(
                  () {
                    if (context.mounted) {
                      AppRouter.instance.pushOff(
                        context: context,
                        screen: const NavbarScreen(),
                      );
                    }
                  },
                );

                return const SizedBox.shrink();
              }

              //*If No Data Available
              else {
                return EmptyDataWidget(
                  subTitle: AppExceptions.instance.normalErrorText,
                );
              }
          }
        },
      ),
    );
  }
}
