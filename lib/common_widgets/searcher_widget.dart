import "package:flutter/material.dart";
import "package:fuzzy/data/result.dart";
import "dart:async";

import "package:fuzzy/fuzzy.dart";

class SearcherWidget<T> extends StatefulWidget {
  SearcherWidget({
    required this.fetchItems,
    required this.itemBuilder,
    this.hintText = "Search...",
    this.searchController,
  });
  final Future<List<T>> Function() fetchItems;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final String hintText;
  final TextEditingController? searchController;
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
              controller: _searchController,
              onChanged: (final String value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: widget.hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
<<<<<<< Updated upstream
            Expanded(
              child: ListView(
                children: Fuzzy<T>(items)
                    .search(query)
                    .map(
                      (final Result<T> item) =>
                          widget.itemBuilder(context, item.item),
                    )
                    .toList(),
              ),
=======
            ListView(
              children: items!
                  .map((final T item) => widget.itemBuilder(context, item))
                  .toList(),
>>>>>>> Stashed changes
            ),
          ],
        )
      : const Center(
          child: CircularProgressIndicator(),
        );
}
