import 'dart:convert';
import 'dart:io';

import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fpdart/fpdart.dart';

final serviceDetailsRepositoryPr = Provider<ServiceDetailsRepository>(
  (ref) {
    return ServiceDetailsRepository(
      paymentServices: ref.read(stripePaymentServicesPr),
      homeServices: ref.read(homeServicesPr),
    );
  },
);

class ServiceDetailsRepository {
  final StripePaymentServices _paymentServices;
  final HomeServices _homeServices;

  ServiceDetailsRepository({
    required StripePaymentServices paymentServices,
    required HomeServices homeServices,
  })  : _paymentServices = paymentServices,
        _homeServices = homeServices;

  //* Make Payment
  FutureEither<String?> makePayment({
    required ServiceJson serviceJson,
    required UserJson? user,
    required String selectedDate,
    required String selectedTimeSlot,
  }) async {
    try {
      ///STEP 1: Create Payment Intent
      final response = await _paymentServices.createPaymentIntent(
        amount: serviceJson.price!,
      );

      if (response == null) {
        return left(
          AppExceptions.instance.handleException(
            error: "Payment intent creation failed",
          ),
        );
      }

      final paymentIntent = jsonDecode(response);

      ///STEP 2: Initialize Payment Sheet
      await _paymentServices.initPaymentSheet(
        clientSecretKey: paymentIntent!['clientSecret'],
        merchantName: user != null ? "${user.firstName} ${user.lastName}" : "",
      );

      //STEP 3: Display Payment sheet
      await _displayPaymentSheet();

      // //STEP 4: Save Payment Details To DB
      // final message = await _saveBookingData(
      //   serviceJson: serviceJson,
      //   user: user,
      //   selectedDate: selectedDate,
      //   selectedTimeSlot: selectedTimeSlot,
      // );

      return right("message");
    } on SocketException {
      return left(AppExceptions.instance.handleSocketException());
    } on MyHttpClientException catch (error) {
      ///Here --> error type: Failure
      return left(AppExceptions.instance.handleMyHTTPClientException(error));
    } on StripeException catch (error) {
      return left(
        AppExceptions.instance.handleException(
          error: error.error.message.toString(),
        ),
      );
    } catch (error) {
      return left(
        AppExceptions.instance.handleException(
          error: error.toString(),
        ),
      );
    }
  }

  ///Display Payment Sheet
  FutureVoid _displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
    await Stripe.instance.confirmPaymentSheetPayment();
  }

  //* Now Save Data to DB
  Future<String> _saveBookingData({
    required ServiceJson serviceJson,
    required UserJson? user,
    required String selectedDate,
    required String selectedTimeSlot,
  }) async {
    final bookingDto = CreateBookingDto(
      userId: user!.userId,
      serviceId: serviceJson.serviceId,
      providerId: serviceJson.providerId,
      date: selectedDate,
      timeSlot: selectedTimeSlot,
      price: serviceJson.price,
      serviceTitle: serviceJson.title,
      providerName: "",
    );

    final response = await _homeServices.createBooking(bookingDto: bookingDto);

    if (response != null) {
      final signUpData = jsonDecode(response);
      return signUpData["message"];
    }

    return "";
  }
}
