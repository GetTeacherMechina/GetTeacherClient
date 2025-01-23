import "package:flutter/material.dart";
import "package:fuzzy/data/result.dart";
import "dart:async";

import "package:fuzzy/fuzzy.dart";
import "package:getteacher/theme/theme.dart";

class SearcherWidget<T> extends StatefulWidget {
  SearcherWidget({
    required this.fetchItems,
    required this.itemBuilder,
    this.hintText = "Search...",
    this.searchController,
    this.search = false,
  });
  final Future<List<T>> Function() fetchItems;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final String hintText;
  final TextEditingController? searchController;
  final bool search;
  @override
  SearcherWidgetState<T> createState() => SearcherWidgetState<T>();
}

class SearcherWidgetState<T> extends State<SearcherWidget<T>> {
  @override
  void didUpdateWidget(covariant final SearcherWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.fetchItems().then(
      (final List<T> value) {
        if (mounted) {
          setState(() {
            items = value;
          });
        }
      },
    );
  }

  TextEditingController _searchController = TextEditingController();
  List<T>? items;
  String query = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      _searchController = widget.searchController ?? _searchController;
    });
    widget.fetchItems().then(
      (final List<T> value) {
        if (mounted) {
          setState(() {
            items = value;
          });
        }
      },
    );
  }

  @override
  Widget build(final BuildContext context) => items != null
      ? Column(
          children: <Widget>[
            TextField(
              onChanged: (final String query) {
                setState(() {
                  this.query = query;
                });
              },
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search for subjects...",
                prefixIcon:
                    const Icon(Icons.search, color: AppTheme.hintTextColor),
                filled: true,
                fillColor: AppTheme.inputFieldBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: Fuzzy<T>(
                  items,
                  options: FuzzyOptions<T>(
                    keys: <WeightedKey<T>>[
                      WeightedKey<T>(
                        name: "",
                        getter: (final T item) => item.toString(),
                        weight: 0.5,
                      ),
                    ],
                  ),
                )
                    .search(query)
                    .map(
                      (final Result<T> item) =>
                          widget.itemBuilder(context, item.item),
                    )
                    .toList(),
              ),
            ),
          ],
        )
      : const Center(
          child: CircularProgressIndicator(),
        );
}
