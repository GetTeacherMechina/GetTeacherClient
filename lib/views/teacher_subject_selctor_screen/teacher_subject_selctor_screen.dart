import "package:flutter/material.dart";
import "package:flutter/material.dart";
import "package:getteacher/net/login/login.dart";
import "package:getteacher/net/net.dart";
import "package:getteacher/net/teacher_subject_selector/teacher_subject_selector.dart";
import "package:getteacher/net/teacher_subject_selector/teacher_subject_selector_handler.dart";

class TeacherSubjectSelctor extends StatefulWidget {
  TeacherSubjectSelctor({super.key});
  
  @override
  State<StatefulWidget> createState() => _TeacherSubjectSelctor();
}

class _TeacherSubjectSelctor extends State<TeacherSubjectSelctor> {

  @override
  Widget build(final BuildContext context) =>  Scaffold(
    body: Form(
      child: Row (
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                FutureBuilder(future: getTeacherSubjectSelector(),
                  builder: (final BuildContext context,
                   final AsyncSnapshot<TeacherSubjectSelectorResponseModel> snapshot) 
                   => snapshot.mapSnapshot(onSuccess: (re) => Text("hi") ),
                  ),  
              ],
            ),
          ),
        ],
      ),
    ),
  );
}