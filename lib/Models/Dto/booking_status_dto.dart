import 'dart:convert';

enum BookingStatus { cancel, confirmed, pending }

class BookingStatusDto {
  final String providerId;
  final String bookingId;
  final BookingStatus status;

  BookingStatusDto({
    required this.providerId,
    required this.bookingId,
    required this.status,
  });

  BookingStatusDto copyWith({
    String? providerId,
    String? bookingId,
    BookingStatus? status,
  }) {
    return BookingStatusDto(
      providerId: providerId ?? this.providerId,
      bookingId: bookingId ?? this.bookingId,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'providerId': providerId,
      'bookingId': bookingId,
      'status': status.name,
    };
  }

  String toJson() => json.encode(toMap());
}
