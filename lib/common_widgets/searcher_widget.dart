import "package:flutter/material.dart";
import "dart:async";

import "package:getteacher/net/net.dart";

class SearcherWidget<T> extends StatefulWidget {
  SearcherWidget(
      {required this.fetchItems,
      required this.itemBuilder,
      this.hintText = "Search...",
      this.searchController}) {}
  final Future<List<T>> Function() fetchItems;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final String hintText;
  final TextEditingController? searchController;
  @override
  SearcherWidgetState<T> createState() => SearcherWidgetState<T>();
}

class SearcherWidgetState<T> extends State<SearcherWidget<T>> {
  TextEditingController _searchController = TextEditingController();
  late final Future<List<T>> future = widget.fetchItems();
  String query = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      _searchController = widget.searchController ?? _searchController;
    });
  }

  @override
  Widget build(final BuildContext context) => FutureBuilder<List<T>>(
        future: future,
        builder: (
          final BuildContext context,
          final AsyncSnapshot<List<T>> snapshot,
        ) =>
            snapshot.mapSnapshot(
          onSuccess: (final List<T> items) => Column(
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
              Expanded(
                child: ListView(
                  children: items
                      .map((final T item) => widget.itemBuilder(context, item))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
}
