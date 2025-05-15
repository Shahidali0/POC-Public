import 'dart:convert';
import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fpdart/fpdart.dart';

final serviceDetailsRepositoryPr = Provider<ServiceDetailsRepository>(
  (ref) {
    return ServiceDetailsRepository(
      paymentServices: ref.read(stripePaymentServicesPr),
      homeServices: ref.read(homeServicesPr),
      profileRepository: ref.read(profileRepositoryPr),
      ref: ref,
    );
  },
);

class ServiceDetailsRepository {
  final StripePaymentServices _paymentServices;
  final HomeServices _homeServices;
  final ProfileRepository _profileRepository;
  final Ref _ref;

  ServiceDetailsRepository({
    required StripePaymentServices paymentServices,
    required HomeServices homeServices,
    required ProfileRepository profileRepository,
    required Ref ref,
  })  : _paymentServices = paymentServices,
        _homeServices = homeServices,
        _profileRepository = profileRepository,
        _ref = ref;

  //* Create Payment Intent to get SecretKey and PaymentId
  FutureEither<String> createPaymentIntent({
    required int amount,
  }) async {
    try {
      ///STEP 1: Create Payment Intent
      final response = await _paymentServices.createPaymentIntent(
        amount: amount,
      );

      if (response == null) {
        return left(
          AppExceptions.instance.handleException(
            error: "Payment intent creation failed",
          ),
        );
      }

      final paymentIntent = jsonDecode(response);
      final clientSecret = paymentIntent['clientSecret'];
      debugPrint(clientSecret);

      return right(clientSecret);
    } on MyHttpClientException catch (error) {
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

  //* Make Payment
  FutureEither<bool> makePayment({
    required String clientSecret,
  }) async {
    try {
      bool isPaymentDone = false;

      ///Load User
      final user = _ref.read(userJsonPr)?.user;

      ///STEP 2: Initialize Payment Sheet
      await _paymentServices.initPaymentSheet(
        clientSecretKey: clientSecret,
        merchantName: "${user!.firstName} ${user.lastName}",
      );

      //STEP 3: Display Payment sheet
      await Stripe.instance.presentPaymentSheet();

      isPaymentDone = true;

      return right(isPaymentDone);
    } on MyHttpClientException catch (error) {
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

  //* Update Payment Status
  FutureEither<String?> updatePaymentStatus({
    required String paymentId,
    required String? bookingId,
    required String serviceId,
    required String status,
  }) async {
    try {
      String message = "";

      ///Load user
      final user = _ref.read(userJsonPr)?.user;

      ///Dto
      final paymentStatusDto = PaymentStatusDto(
        paymentId: paymentId,
        bookingId: bookingId,
        serviceId: serviceId,
        userId: user!.userId!,
        status: status,
      );

      final statusResponse = await _paymentServices.updatePaymentStatus(
        paymentStatusDto: paymentStatusDto,
      );

      if (statusResponse != null) {
        final response = jsonDecode(statusResponse);
        message = response["message"];
      }

      return right(message);
    } on MyHttpClientException catch (error) {
      return left(AppExceptions.instance.handleMyHTTPClientException(error));
    } catch (error) {
      return left(
        AppExceptions.instance.handleException(
          error: error.toString(),
        ),
      );
    }
  }

  //* Now Save Booking to DB
  FutureEither<CreateBookingJson?> saveBooking({
    required ServiceJson serviceJson,
    required UserJson? user,
    required String selectedDate,
    required String selectedTimeSlot,
  }) async {
    try {
      CreateBookingJson? createBookingJson;

      ///Now Fetch Provider Details
      final provider = await _profileRepository.getUserByUserId(
        userId: serviceJson.providerId!,
      );

      ///Booking Dto--For saving Bookings
      final bookingDto = CreateBookingDto(
        userId: user!.userId,
        serviceId: serviceJson.serviceId,
        providerId: serviceJson.providerId,
        date: selectedDate.formatYMMMdToDateTime.toIso8601String(),
        timeSlot: selectedTimeSlot,
        price: serviceJson.price,
        serviceTitle: serviceJson.title,
        providerName:
            "${provider?.user?.firstName} ${provider?.user?.lastName}",
      );

      final response =
          await _homeServices.createBooking(bookingDto: bookingDto);

      if (response != null) {
        createBookingJson = CreateBookingJson.fromRawJson(response);
      }

      return right(createBookingJson);
    } on MyHttpClientException catch (error) {
      return left(AppExceptions.instance.handleMyHTTPClientException(error));
    } catch (error) {
      return left(
        AppExceptions.instance.handleException(
          error: error.toString(),
        ),
      );
    }
  }
}
