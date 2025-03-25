import 'dart:convert';

class AllServicesJson {
  final List<ServiceJson>? services;

  AllServicesJson({
    this.services,
  });

  factory AllServicesJson.fromRawJson(String str) =>
      AllServicesJson.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllServicesJson.fromJson(Map<String, dynamic> json) =>
      AllServicesJson(
        services: json["services"] == null
            ? []
            : List<ServiceJson>.from(
                json["services"]!.map((x) => ServiceJson.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "services": services == null
            ? []
            : List<dynamic>.from(services!.map((x) => x.toJson())),
      };
}

class ServiceJson {
  final String? location;
  final DateTime? createdAt;
  final Map<String, List<String>>? timeSlots;
  final String? sport;
  final String? subcategory;
  final String? subcategoryLocation;
  final String? providerId;
  final String? sportCategory;
  final String? category;
  final String? serviceId;
  final String? description;
  final int? price;
  final List<String>? duration;
  final String? title;

  ServiceJson({
    this.location,
    this.createdAt,
    this.timeSlots,
    this.sport,
    this.subcategory,
    this.subcategoryLocation,
    this.providerId,
    this.sportCategory,
    this.category,
    this.serviceId,
    this.description,
    this.price,
    this.duration,
    this.title,
  });

  factory ServiceJson.fromRawJson(String str) =>
      ServiceJson.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceJson.fromJson(Map<String, dynamic> json) => ServiceJson(
        location: json["location"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        timeSlots: Map.from(json["timeSlots"]!).map((k, v) =>
            MapEntry<String, List<String>>(
                k, List<String>.from(v.map((x) => x)))),
        sport: json["sport"],
        subcategory: json["subcategory"],
        subcategoryLocation: json["subcategory_location"],
        providerId: json["providerId"],
        sportCategory: json["sport_category"],
        category: json["category"],
        serviceId: json["serviceId"],
        description: json["description"],
        price: json["price"],
        duration: json["duration"] == null
            ? []
            : List<String>.from(json["duration"]!.map((x) => x)),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "createdAt": createdAt?.toIso8601String(),
        "timeSlots": Map.from(timeSlots!).map((k, v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
        "sport": sport,
        "subcategory": subcategory,
        "subcategory_location": subcategoryLocation,
        "providerId": providerId,
        "sport_category": sportCategory,
        "category": category,
        "serviceId": serviceId,
        "description": description,
        "price": price,
        "duration":
            duration == null ? [] : List<dynamic>.from(duration!.map((x) => x)),
        "title": title,
      };
}
