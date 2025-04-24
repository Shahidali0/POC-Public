import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeSearchDelegate extends SearchDelegate<SearchFilterModel?> {
  final List<SearchFilterModel> searchFilterData;

  HomeSearchDelegate(this.searchFilterData);

  @override
  String get searchFieldLabel => "Search for coaching, training or services…";

  String get searchFieldEmpty => "No results found";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        titleSpacing: 4,
        backgroundColor: AppColors.lightBlue,
        foregroundColor: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: AppColors.blueGrey),
        border: InputBorder.none,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: AppColors.black,
          fontSize: Sizes.fontSize18,
          fontFamily: AppTheme.boldFont,
        ),
      ),
    );
  }

  ///Actions to be shown in the app bar
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        TextButton(
          onPressed: () {
            query = '';
          },
          child: Text(
            "Clear",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColors.red,
                ),
          ),
        ),
    ];
  }

  ///Leading widget to be shown in the app bar
  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton(
      onPressed: () => close(context, null),
    );
  }

  ///This method is called when the user presses the search button
  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return emptyList(
        context: context,
        text: searchFieldEmpty,
      );
    }

    // Filter the list of categories based on the query
    // and convert it to a list
    final results = searchFilterData
        .where(
            (item) => item.result.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildResultsList(
      context: context,
      items: results,
    );
  }

  /// This method is called when the user types in the search bar
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return emptyList(
        context: context,
        text: searchFieldLabel,
      );
    }

    final suggestions = searchFilterData
        .where(
            (item) => item.result.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildResultsList(
      context: context,
      items: suggestions,
    );
  }

  ///Get Sport, Category and SubCategory Labels
  String getSportCategoryLabel({
    required SearchFilterModel item,
  }) {
    final sport = item.sport ?? "";
    final category = item.category == null ? "" : "→ ${item.category}";
    final subCategory = item.subCategory == null ? "" : "→ ${item.subCategory}";

    return "$sport $category $subCategory";
  }

  /// This method builds the list of results or suggestions
  Widget _buildResultsList({
    required BuildContext context,
    required List<SearchFilterModel> items,
  }) {
    ///If the list is empty, show a message
    if (items.isEmpty) {
      return emptyList(
        context: context,
        text: searchFieldEmpty,
      );
    }

    ///Else show the list of results
    return SafeArea(
      child: ListView.separated(
        itemCount: items.length,
        padding: Sizes.globalPadding,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: Sizes.spaceHeight),
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              onTap: () {
                close(context, item);
              },
              leading: const Icon(
                CupertinoIcons.search,
                color: AppColors.black,
              ),
              trailing: const Icon(
                Icons.chevron_right_outlined,
                color: AppColors.black,
              ),
              title: Text(
                item.result,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontFamily: AppTheme.regularFont,
                      fontSize: Sizes.fontSize18,
                    ),
              ),
              subtitle: Text(
                getSportCategoryLabel(item: item),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontFamily: AppTheme.regularFont,
                      color: AppColors.black,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// This method builds the empty list when there are
  /// no suggestions or results found
  Widget emptyList({
    required BuildContext context,
    required String text,
  }) {
    return Center(
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: Sizes.fontSize18,
            ),
      ),
    );
  }
}
