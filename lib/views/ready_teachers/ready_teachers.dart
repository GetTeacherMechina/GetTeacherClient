import "package:json_annotation/json_annotation.dart";

part "ready_teachers.g.dart";

@JsonSerializable()
class ReadyTeachers {
  ReadyTeachers({required this.readyTeachers});

  /// Factory constructor for creating a new `ReadyTeachers` instance from a map.
  factory ReadyTeachers.fromJson(final Map<String, dynamic> json) =>
      _$ReadyTeachersFromJson(json);
  final List<SubjectGradeReadyTeachers> readyTeachers;

  /// Method for converting a `ReadyTeachers` instance into a map.
  Map<String, dynamic> toJson() => _$ReadyTeachersToJson(this);

  int amountOfTeachersPerSubjectGrade(
    final String subject,
    final String grade,
  ) =>
      readyTeachers
          .where(
            (final SubjectGradeReadyTeachers t) =>
                t.grade.name == grade && t.subject.name == subject,
          )
          .fold(
            0,
            (final int acc, final SubjectGradeReadyTeachers t) =>
                acc + t.readyTeachersCount,
          );
}

@JsonSerializable()
class SubjectGradeReadyTeachers {
  SubjectGradeReadyTeachers({
    required this.subject,
    required this.grade,
    required this.readyTeachersCount,
  });

  /// Factory constructor for creating a new `SubjectGradeReadyTeachers` instance from a map.
  factory SubjectGradeReadyTeachers.fromJson(final Map<String, dynamic> json) =>
      _$SubjectGradeReadyTeachersFromJson(json);

  @JsonKey(name: "Subject")
  final WebsocketSubject subject;

  @JsonKey(name: "Grade")
  final WebsocketGrade grade;

  @JsonKey(name: "ReadyTeachersCount")
  final int readyTeachersCount;

  /// Method for converting a `SubjectGradeReadyTeachers` instance into a map.
  Map<String, dynamic> toJson() => _$SubjectGradeReadyTeachersToJson(this);
}

@JsonSerializable()
class WebsocketSubject {
  WebsocketSubject({required this.name});

  factory WebsocketSubject.fromJson(final Map<String, dynamic> json) =>
      _$WebsocketSubjectFromJson(json);

  @JsonKey(name: "Name")
  final String name;
}

@JsonSerializable()
class WebsocketGrade {
  WebsocketGrade({required this.name});

  factory WebsocketGrade.fromJson(final Map<String, dynamic> json) =>
      _$WebsocketGradeFromJson(json);

  @JsonKey(name: "Name")
  final String name;
}
