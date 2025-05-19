import 'dart:convert';

class LocationsJson {
  final String? postcode;
  final DateTime? createdAt;
  final String? location;

  LocationsJson({
    this.postcode,
    this.createdAt,
    this.location,
  });

  LocationsJson copyWith({
    String? postcode,
    DateTime? createdAt,
    String? location,
  }) =>
      LocationsJson(
        postcode: postcode ?? this.postcode,
        createdAt: createdAt ?? this.createdAt,
        location: location ?? this.location,
      );

  static List<LocationsJson> fromRawJson(String str) =>
      List<LocationsJson>.from(
          json.decode(str).map((x) => LocationsJson.fromJson(x)));

  String toRawJson() => json.encode(toJson());

  factory LocationsJson.fromJson(Map<String, dynamic> json) => LocationsJson(
        postcode: json["postcode"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "postcode": postcode,
        "createdAt": createdAt?.toIso8601String(),
        "location": location,
      };
}
