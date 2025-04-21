class SearchFilterModel {
  String result;
  String? sport;
  String? category;
  String? subCategory;

  SearchFilterModel({
    required this.result,
    this.sport,
    this.category,
    this.subCategory,
  });

  SearchFilterModel copyWith({
    String? result,
    String? sport,
    String? category,
    String? subCategory,
  }) {
    return SearchFilterModel(
      result: result ?? this.result,
      sport: sport ?? this.sport,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
    );
  }

  @override
  String toString() {
    return 'SearchFilterModel(result: $result, sport: $sport, category: $category, subCategory: $subCategory)';
  }

  @override
  bool operator ==(covariant SearchFilterModel other) {
    if (identical(this, other)) return true;

    return other.result == result &&
        other.sport == sport &&
        other.category == category &&
        other.subCategory == subCategory;
  }

  @override
  int get hashCode {
    return result.hashCode ^
        sport.hashCode ^
        category.hashCode ^
        subCategory.hashCode;
  }
}
