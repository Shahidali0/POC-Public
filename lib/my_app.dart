import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      // showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme(context),
      theme: AppTheme.lightTheme(context),
      themeMode: ThemeMode.light,

      builder: (context, child) => Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: child!,
      ),

      home: Consumer(
        builder: (_, WidgetRef ref, __) {
          return ref.watch(autoSignInPr).when(
                data: (showIntro) {
                  FlutterNativeSplash.remove();
                  if (showIntro) {
                    return const IntroScreen();
                  }

                  return const DashboardScreen();
                },
                error: (error, stackTrace) => ErrorText(
                  title: AppExceptions.instance.serverError,
                  error: AppExceptions.instance.normalErrorText,
                  onRefresh: () => ref.refresh(autoSignInPr),
                ),
                loading: () => const ShowPlatformLoader(),
              );
        },
      ),
    );
  }
}
