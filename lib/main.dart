import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  ///Initialize Flutter Binding
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  ///Initialize Splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //Assign publishable key to flutter_stripe
  Stripe.publishableKey = MyKeys.instance.stripePublishableKey;

  //Apply Settings --For Stripe
  await Stripe.instance.applySettings();

  // LocalStorage().deleteLoginDetails();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlayMate',
      // showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme(context),
      theme: AppTheme.lightTheme(context),
      themeMode: ThemeMode.light,
      // home: const DashboardNavbarScreen(),
      home: Consumer(
        builder: (_, WidgetRef ref, __) {
          return ref.watch(autoSignInPr).when(
                data: (isAuthorized) {
                  FlutterNativeSplash.remove();

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

class Spash extends StatelessWidget {
  const Spash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
