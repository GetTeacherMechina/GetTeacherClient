import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";
import "package:getteacher/net/subject_search/subject_search.dart";

class StudentSearchWidget extends StatefulWidget {
  const StudentSearchWidget({
    super.key,
    required this.onSubjectSelected,
    required this.selectedItem,
  });

  final void Function(String) onSubjectSelected;
  final String selectedItem;

  @override
  _StudentSearchWidgetState createState() => _StudentSearchWidgetState();
}

class _StudentSearchWidgetState extends State<StudentSearchWidget> {
  final TextEditingController controller = TextEditingController();
  late Future<List<String>> _fetchItemsFuture;

  @override
  void initState() {
    super.initState();
    _fetchItemsFuture = subjectSearch();
  }

  void _refreshSubjects() {
    setState(() {
      _fetchItemsFuture = subjectSearch();
    });
  }

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Search for subjects...",
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _refreshSubjects,
                tooltip: "Refresh Subjects",
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<String>>(
              future: _fetchItemsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No subjects found."));
                }

                final items = snapshot.data!;

                return SearcherWidget<String>(
                  fetchItems: () async => items,
                  itemBuilder:
                      (final BuildContext context, final String item) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      selected: item == widget.selectedItem,
                      onTap: () {
                        widget.onSubjectSelected(item);
                      },
                      leading: const Icon(Icons.book),
                      title: Text(item),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
}
