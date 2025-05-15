import 'dart:convert';

class CreateBookingJson {
  final String? message;
  final String? bookingId;

  CreateBookingJson({
    this.message,
    this.bookingId,
  });

  CreateBookingJson copyWith({
    String? message,
    String? bookingId,
  }) =>
      CreateBookingJson(
        message: message ?? this.message,
        bookingId: bookingId ?? this.bookingId,
      );

  factory CreateBookingJson.fromRawJson(String str) =>
      CreateBookingJson.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateBookingJson.fromJson(Map<String, dynamic> json) =>
      CreateBookingJson(
        message: json["message"],
        bookingId: json["bookingId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "bookingId": bookingId,
      };
}
