import 'package:cricket_poc/lib_exports.dart';

class MyKeys {
  MyKeys._();

  static MyKeys get instance => MyKeys._();

  String get stripeSecretKey => dotenv.env['STRIPE_SECRET_KEY']!;

  String get stripePublishableKey => dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
}
