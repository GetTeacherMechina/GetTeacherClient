import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";
import "package:getteacher/net/subject_search/subject_search.dart";
import "package:getteacher/net/subject_search/subject_search_net_model.dart";

class SubjectSearchWidget extends StatelessWidget {
  Future<List<String>> fetchSubjectsFromApi() async {
    final List<SubjectModel> results = await subjectSearch();
    return results.map((final SubjectModel subject) => subject.name).toList();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Search Subjects - student"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SearcherWidget<String>(
            fetchItems: fetchSubjectsFromApi(),
            itemBuilder: (final BuildContext context, final String item) =>
                Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(Icons.book),
                title: Text(item),
              ),
            ),
            hintText: "Search for subjects...",
          ),
        ),
      );
}
