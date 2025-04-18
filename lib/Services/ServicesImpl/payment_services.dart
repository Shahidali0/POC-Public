import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

final stripePaymentServicesPr = Provider<StripePaymentServices>((ref) {
  return _StripePaymentServicesImpl();
});

sealed class StripePaymentServices {
  Future<String?> createPaymentIntent({
    required int amount,
    required String currency,
  });

  FutureVoid initPaymentSheet({
    required String clientSecretKey,
    required String merchantName,
  });
}

class _StripePaymentServicesImpl implements StripePaymentServices {
  ///Create Payment Intent -- To get ClientSecret Key
  @override
  Future<String?> createPaymentIntent({
    required int amount,
    required String currency,
  }) async {
    ///Request body
    Map<String, dynamic> body = {
      'amount': _calculateAmount(amount),
      'currency': currency,
    };

    ///Make post request to Stripe
    final response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization': 'Bearer ${MyKeys.instance.stripeSecretKey}',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body,
    );

    return ResponseHandler.instance.handleResponse(response: response);
  }

  //* Init Stripe Payment Sheet
  @override
  FutureVoid initPaymentSheet({
    required String clientSecretKey,
    required String merchantName,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecretKey, //Gotten from payment intent
        style: ThemeMode.system,
        merchantDisplayName: merchantName,
        appearance: const PaymentSheetAppearance(
          ///Button
          primaryButton: PaymentSheetPrimaryButtonAppearance(
            colors: PaymentSheetPrimaryButtonTheme(
              light: PaymentSheetPrimaryButtonThemeColors(
                background: AppColors.appTheme,
                text: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Calculate Amount
String _calculateAmount(int amount) {
  final calculatedAmout = amount * 100;
  return calculatedAmout.toString();
}
