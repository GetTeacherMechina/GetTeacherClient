import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/net/subject_search/subject_search.dart";
import "package:getteacher/theme/theme.dart";
import "package:getteacher/views/ready_teachers/ready_teachers.dart";

class StudentSearchWidget extends StatefulWidget {
  StudentSearchWidget({
    super.key,
    required this.onSubjectSelected,
    required this.selectedItem,
    required this.profile,
    required this.readyTeachers,
  });

  final void Function(String) onSubjectSelected;
  final String selectedItem;
  final ReadyTeachers readyTeachers;
  final StudentProfile profile;

  @override
  State<StudentSearchWidget> createState() => _StudentSearchWidgetState();
}

class _StudentSearchWidgetState extends State<StudentSearchWidget> {
  final TextEditingController controller = TextEditingController();
  List<String> searchedSubjects = <String>[];

  // void _performSearch() {
  //   final String searchQuery = controller.text.trim();
  //   if (searchQuery.isNotEmpty && !searchedSubjects.contains(searchQuery)) {
  //     setState(() {
  //       searchedSubjects.add(searchQuery);
  //       controller.clear();
  //     });
  //   }
  // }

  @override
  Widget build(final BuildContext context) => SearcherWidget<String>(
        fetchItems: subjectSearch,
        itemBuilder: (final BuildContext context, final String subject) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: ListTile(
            selected: subject == widget.selectedItem,
            onTap: () {
              widget.onSubjectSelected(subject);
            },
            leading: const Icon(
              Icons.book,
              color: AppTheme.primaryColor,
            ),
            title: Text(
              subject,
              style: TextStyle(
                color: subject == widget.selectedItem
                    ? AppTheme.primaryColor
                    : AppTheme.textColor,
              ),
            ),
            trailing: Text(
                "Currently ${widget.readyTeachers.amountOfTeachersPerSubjectGrade(subject, widget.profile.grade.name)} teachers online"),
          ),
        ),
      );

//   Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const SizedBox(height: 20),
//           Column(
//             children: searchedSubjects
//                 .map(
//                   (final String subject) =>
//                 )
//                 .toList(),
//           ),
//         ],
//       );
}
