import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";
import "package:getteacher/net/subject_search/subject_search.dart";

class StudentSearchWidget extends StatelessWidget {
  StudentSearchWidget({
    super.key,
    required this.onSubjectSelected,
    required this.selectedItem,
  });

  final void Function(String) onSubjectSelected;
  final String selectedItem;

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(final BuildContext context) => SearcherWidget<String>(
        fetchItems: subjectSearch,
        itemBuilder: (final BuildContext context, final String item) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            selected: item == selectedItem,
            onTap: () {
              onSubjectSelected(item);
            },
            leading: const Icon(Icons.book),
            title: Text(item),
          ),
        ),
        hintText: "Search for subjects...",
      );
}
