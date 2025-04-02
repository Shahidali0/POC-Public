import 'dart:convert';

class CategoryJson {
  final String? category;
  final String? sport;
  final List<String>? subcategories;

  CategoryJson({
    this.category,
    this.sport,
    this.subcategories,
  });

  CategoryJson copyWith({
    String? category,
    String? sport,
    List<String>? subcategories,
  }) =>
      CategoryJson(
        category: category ?? this.category,
        sport: sport ?? this.sport,
        subcategories: subcategories ?? this.subcategories,
      );

  static List<CategoryJson> fromRawJson(String str) => List<CategoryJson>.from(
        json.decode(str).map((x) => CategoryJson.fromJson(x)),
      );

  static String toRawJson(List<CategoryJson> data) => json.encode(
        List<dynamic>.from(data.map((x) => x.toJson())),
      );

  factory CategoryJson.fromJson(Map<String, dynamic> json) => CategoryJson(
        category: json["category"],
        sport: json["sport"],
        subcategories: json["subcategories"] == null
            ? []
            : List<String>.from(json["subcategories"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "sport": sport,
        "subcategories": subcategories == null
            ? []
            : List<dynamic>.from(subcategories!.map((x) => x)),
      };
}
