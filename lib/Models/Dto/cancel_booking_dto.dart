import 'dart:convert';

import 'package:cricket_poc/lib_exports.dart';

class CancelBookingDto {
  final String userId;
  final String bookingId;
  final BookingStatus status;

  CancelBookingDto({
    required this.userId,
    required this.bookingId,
    required this.status,
  });

  CancelBookingDto copyWith({
    String? userId,
    String? bookingId,
    BookingStatus? status,
  }) {
    return CancelBookingDto(
      userId: userId ?? this.userId,
      bookingId: bookingId ?? this.bookingId,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'bookingId': bookingId,
      'status': status.name,
    };
  }

  String toJson() => json.encode(toMap());
}
