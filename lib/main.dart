import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  //Initialize Flutter Binding
  WidgetsFlutterBinding.ensureInitialized();

  //Assign publishable key to flutter_stripe
  Stripe.publishableKey = MyKeys.instance.stripePublishableKey;

  //Apply Settings
  await Stripe.instance.applySettings();

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
      // home: const IntroScreen(),
      // home: const LocationScreen(),
      home: const DashboardNavbarScreen(),
      // home: const LoginScreen(),
      // home: const OtpVerificationScreen(
      //   emailId: "shahid@asztechnologies.com",
      // ),
    );
  }
}
