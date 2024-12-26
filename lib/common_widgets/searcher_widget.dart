import "package:flutter/material.dart";
import "dart:async";

class SearcherWidget<T> extends StatefulWidget {
  SearcherWidget({
    required this.fetchItems,
    required this.itemBuilder,
    this.hintText = "Search...",
  });
  final Future<List<T>> Function(String? query) fetchItems;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final String hintText;

  @override
  SearcherWidgetState<T> createState() => SearcherWidgetState<T>();
}

class SearcherWidgetState<T> extends State<SearcherWidget<T>> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<T> _items = <T>[];
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchItems(
        _searchController.text,
      );
    });
  }

  Future<void> _fetchItems(final String? query) async {
    if (query == null) {
      setState(() {
        _items = <T>[];
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final List<T> data = await widget.fetchItems(query);
      setState(() {
        _items = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _items = <T>[];
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching items: $e")),
      );
    }
  }
  @override
  void initState() {
    super.initState();
    _fetchItems("");
  }

  @override
  Widget build(final BuildContext context) => Column(
        children: <Widget>[
          TextField(
            controller: _searchController,
            onChanged: (final String value) => _onSearchChanged(),
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
          _isLoading
              ? const CircularProgressIndicator()
              : _items.isEmpty
                  ? const Text(
                      "No items found",
                      style: TextStyle(color: Colors.grey),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _items.length,
                        itemBuilder:
                            (final BuildContext context, final int index) =>
                                widget.itemBuilder(context, _items[index]),
                      ),
                    ),
        ],
      );
}
