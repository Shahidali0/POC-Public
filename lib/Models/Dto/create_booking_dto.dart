import 'dart:convert';

class CreateBookingDto {
  final String? userId;
  final String? serviceId;
  final String? providerId;
  final String? date;
  final String? timeSlot;
  final int? price;
  final String? serviceTitle;
  final String? providerName;

  CreateBookingDto({
    required this.userId,
    required this.serviceId,
    required this.providerId,
    required this.date,
    required this.timeSlot,
    required this.price,
    required this.serviceTitle,
    required this.providerName,
  });

  CreateBookingDto copyWith({
    String? userId,
    String? serviceId,
    String? providerId,
    String? date,
    String? timeSlot,
    int? price,
    String? serviceTitle,
    String? providerName,
  }) =>
      CreateBookingDto(
        userId: userId ?? this.userId,
        serviceId: serviceId ?? this.serviceId,
        providerId: providerId ?? this.providerId,
        date: date ?? this.date,
        timeSlot: timeSlot ?? this.timeSlot,
        price: price ?? this.price,
        serviceTitle: serviceTitle ?? this.serviceTitle,
        providerName: providerName ?? this.providerName,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "serviceId": serviceId,
        "providerId": providerId,
        "date": date,
        "timeSlot": timeSlot,
        "price": price,
        "serviceTitle": serviceTitle,
        "providerName": providerName,
      };
}
