import "package:json_annotation/json_annotation.dart";

part "register_net_model.g.dart";

@JsonSerializable()
class RegisterRequestModel {
  RegisterRequestModel({
    required this.fullName,
    required this.password,
    required this.email,
    required this.teacher,
    required this.student,
  });

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);

  final String fullName;
  final String password;
  final String email;

  final TeacherRequestModel? teacher;
  final StudentRequestModel? student;
}

@JsonSerializable()
class StudentRequestModel {
  const StudentRequestModel({required this.grade});

  factory StudentRequestModel.fromJson(final Map<String, dynamic> json) =>
      _$StudentRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentRequestModelToJson(this);

  final String grade;
}

@JsonSerializable()
class TeacherRequestModel {
  const TeacherRequestModel({required this.bio});

  factory TeacherRequestModel.fromJson(final Map<String, dynamic> json) =>
      _$TeacherRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherRequestModelToJson(this);

  final String bio;
}
