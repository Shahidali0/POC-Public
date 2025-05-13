import 'dart:convert';

class NotificationJson {
  final String? bookingId;
  final String? userId;
  String? status;
  final DateTime? createdAt;
  final dynamic serviceId;
  final String? eventType;
  final String? message;
  final String? type;

  NotificationJson({
    this.bookingId,
    this.userId,
    this.status,
    this.createdAt,
    this.serviceId,
    this.eventType,
    this.message,
    this.type,
  });

  NotificationJson copyWith({
    String? bookingId,
    String? userId,
    String? status,
    DateTime? createdAt,
    dynamic serviceId,
    String? eventType,
    String? message,
    String? type,
  }) =>
      NotificationJson(
        bookingId: bookingId ?? this.bookingId,
        userId: userId ?? this.userId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        serviceId: serviceId ?? this.serviceId,
        eventType: eventType ?? this.eventType,
        message: message ?? this.message,
        type: type ?? this.type,
      );
  static List<NotificationJson> fromRawJson(String str) =>
      List<NotificationJson>.from(
          json.decode(str).map((x) => NotificationJson.fromJson(x)));

  static String toRawJson(List<NotificationJson> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  factory NotificationJson.fromJson(Map<String, dynamic> json) =>
      NotificationJson(
        bookingId: json["bookingId"],
        userId: json["userId"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        serviceId: json["serviceId"],
        eventType: json["eventType"],
        message: json["message"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "bookingId": bookingId,
        "userId": userId,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "serviceId": serviceId,
        "eventType": eventType,
        "message": message,
        "type": type,
      };
}
