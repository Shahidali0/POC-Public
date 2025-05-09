import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
// final navigatorKey = GlobalKey<NavigatorState>();

///Main Initialization
///This is the main entry point of the application
FutureVoid _initialize() async {
  ///Initialize Flutter Binding
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  ///Initialize Splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //Assign publishable key to flutter_stripe
  Stripe.publishableKey = MyKeys.instance.stripePublishableKey;

  //Apply Settings --For Stripe
  await Stripe.instance.applySettings();
}

///Entry point of the application
void main() async {
  await _initialize();
  runApp(const ProviderScope(child: MyApp()));
}
