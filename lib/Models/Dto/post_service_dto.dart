import 'dart:convert';

class PostServiceDto {
  final String providerId;
  final String title;
  final String sport;
  final String description;
  final List<String> duration;
  final String location;
  final int price;
  final String category;
  final String subcategory;
  final Map<String, List<String>> timeSlots;

  PostServiceDto({
    required this.providerId,
    required this.title,
    required this.sport,
    required this.description,
    required this.duration,
    required this.location,
    required this.price,
    required this.category,
    required this.subcategory,
    required this.timeSlots,
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "providerId": providerId,
        "title": title,
        "sport": sport,
        "description": description,
        "duration": List<dynamic>.from(duration.map((x) => x)),
        "location": location,
        "price": price,
        "category": category,
        "subcategory": subcategory,
        "timeSlots": Map.from(timeSlots).map((k, v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
      };
}
