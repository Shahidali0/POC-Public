import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class HomeSearchDelegate extends SearchDelegate<SearchFilterModel?> {
  final List<SearchFilterModel> searchFilterData;

  HomeSearchDelegate(this.searchFilterData);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
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
        IconButton(
          icon: const Icon(Icons.clear),
          color: AppColors.red,
          onPressed: () {
            query = '';
          },
        )
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
      return emptyList(context);
    }

    // Filter the list of categories based on the query
    // and convert it to a list
    final results = searchFilterData
        .where(
            (item) => item.result.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildResultsList(results);
  }

  /// This method is called when the user types in the search bar
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return emptyList(context);
    }

    final suggestions = searchFilterData
        .where(
            (item) => item.result.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildResultsList(suggestions);
  }

  /// This method builds the list of results or suggestions
  Widget _buildResultsList(List<SearchFilterModel> items) {
    return ListView.separated(
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
              Icons.category_outlined,
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
                    fontSize: Sizes.fontSize16,
                    fontFamily: AppTheme.boldFont,
                  ),
            ),
          ),
        );
      },
    );
  }

  /// This method builds the empty list when there are
  /// no suggestions or results found
  Widget emptyList(BuildContext context) {
    return Center(
      child: Text(
        'Search for coaching, training or services…',
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
