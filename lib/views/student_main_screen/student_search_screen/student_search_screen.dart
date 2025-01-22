import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";
import "package:getteacher/net/subject_search/subject_search.dart";
import "package:getteacher/theme/theme.dart";

class StudentSearchWidget extends StatefulWidget {
  StudentSearchWidget({
    super.key,
    required this.onSubjectSelected,
    required this.selectedItem,
  });

  final void Function(String) onSubjectSelected;
  final String selectedItem;

  @override
  State<StudentSearchWidget> createState() => _StudentSearchWidgetState();
}

class _StudentSearchWidgetState extends State<StudentSearchWidget> {
  final TextEditingController controller = TextEditingController();
  List<String> searchedSubjects = [];

  void _performSearch() {
    final String searchQuery = controller.text.trim();
    if (searchQuery.isNotEmpty && !searchedSubjects.contains(searchQuery)) {
      setState(() {
        searchedSubjects.add(searchQuery);
        controller.clear();
      });
    }
  }

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Search for subjects...",
              prefixIcon: IconButton(
                icon: Icon(Icons.search, color: AppTheme.hintTextColor),
                onPressed: _performSearch,
              ),
              filled: true,
              fillColor: AppTheme.inputFieldBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (value) => _performSearch(),
          ),
          const SizedBox(height: 20),
          Column(
            children: searchedSubjects.map((subject) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                  child: ListTile(
                    selected: subject == widget.selectedItem,
                    onTap: () {
                      widget.onSubjectSelected(subject);
                    },
                    leading: Icon(Icons.book, color: AppTheme.primaryColor),
                    title: Text(
                      subject,
                      style: TextStyle(
                        color: subject == widget.selectedItem
                            ? AppTheme.primaryColor
                            : AppTheme.textColor,
                      ),
                    ),
                  ),
                )).toList(),
          ),
        ],
      );
}
