import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

void main() {
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
