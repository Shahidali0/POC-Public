import 'dart:convert';

class BookingsJson {
  final String? bookingId;
  final DateTime? date;
  final String? providerId;
  final String? userId;
  final String? status;
  final DateTime? createdAt;
  final String? serviceId;
  final int? price;
  final String? timeSlot;

  BookingsJson({
    this.bookingId,
    this.date,
    this.providerId,
    this.userId,
    this.status,
    this.createdAt,
    this.serviceId,
    this.price,
    this.timeSlot,
  });

  static List<BookingsJson> fromRawJson(String str) => List<BookingsJson>.from(
      json.decode(str).map((x) => BookingsJson.fromJson(x)));

  String toRawJson(List<BookingsJson> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  factory BookingsJson.fromJson(Map<String, dynamic> json) => BookingsJson(
        bookingId: json["bookingId"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        providerId: json["providerId"],
        userId: json["userId"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        serviceId: json["serviceId"],
        price: json["price"],
        timeSlot: json["timeSlot"],
      );

  Map<String, dynamic> toJson() => {
        "bookingId": bookingId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "providerId": providerId,
        "userId": userId,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "serviceId": serviceId,
        "price": price,
        "timeSlot": timeSlot,
      };
}
