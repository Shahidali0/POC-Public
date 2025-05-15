import 'dart:convert';

class PaymentStatusDto {
  final String paymentId;
  final String? bookingId;
  final String serviceId;
  final String userId;
  final String status;

  PaymentStatusDto({
    required this.paymentId,
    required this.bookingId,
    required this.serviceId,
    required this.userId,
    required this.status,
  });

  PaymentStatusDto copyWith({
    String? paymentId,
    String? bookingId,
    String? serviceId,
    String? userId,
    String? status,
  }) =>
      PaymentStatusDto(
        paymentId: paymentId ?? this.paymentId,
        bookingId: bookingId ?? this.bookingId,
        serviceId: serviceId ?? this.serviceId,
        userId: userId ?? this.userId,
        status: status ?? this.status,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "paymentId": paymentId,
        "bookingId": bookingId,
        "serviceId": serviceId,
        "userId": userId,
        "status": status,
      };
}
