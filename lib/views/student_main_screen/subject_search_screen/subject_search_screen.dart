import "package:flutter/material.dart";
import "dart:async";

class SubjectSearchWidget extends StatefulWidget {
  @override
  SubjectSearchWidgetState createState() => SubjectSearchWidgetState();
}

class SubjectSearchWidgetState extends State<SubjectSearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<String> _subjects = <String>[];
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
      _fetchSubjects(_searchController.text);
    });
  }

  Future<void> _fetchSubjects(final String query) async {
    if (query.isEmpty) {
      setState(() {
        _subjects = <String>[];
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final List<String> data = await fetchSubjectsFromApi(query);
      setState(() {
        _subjects = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _subjects = <String>[];
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching subjects: $e")),
      );
    }
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Search Subjects"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _searchController,
                onChanged: (final String value) => _onSearchChanged(),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search for subjects...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : _subjects.isEmpty
                      ? const Text(
                          "No subjects found",
                          style: TextStyle(color: Colors.grey),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: _subjects.length,
                            itemBuilder:
                                (final BuildContext context, final int index) =>
                                    Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                leading: const Icon(Icons.book),
                                title: Text(_subjects[index]),
                              ),
                            ),
                          ),
                        ),
            ],
          ),
        ),
      );
}

Future<List<String>> fetchSubjectsFromApi(final String query) async {
  // Replace this with your actual network implementation
  await Future<void>.delayed(const Duration(seconds: 1));
  return <String>["Subject 1", "Subject 2", "Subject 3"]; // Example data
}
