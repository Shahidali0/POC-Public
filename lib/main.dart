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

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return MaterialApp(
      title: 'PlayMate',
      // showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme(context),
      theme: AppTheme.lightTheme(context),
      themeMode: ThemeMode.light,
      home: const DashboardNavbarScreen(),
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
