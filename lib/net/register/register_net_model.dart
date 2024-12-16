import "package:json_annotation/json_annotation.dart";

part "register_net_model.g.dart";

@JsonSerializable()
class RegisterRequestModel {
  RegisterRequestModel({
    required this.fullName,
    required this.password,
    required this.email,
    required this.teacherRequestModel,
  });

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);

  @JsonKey(name: "FullName")
  final String fullName;
  @JsonKey(name: "Password")
  final String password;
  @JsonKey(name: "Email")
  final String email;

  @JsonKey(name: "Teacher", required: false, disallowNullValue: true)
  final TeacherRequestModel? teacherRequestModel;
}

@JsonSerializable()
class TeacherRequestModel {
  const TeacherRequestModel({required this.bio});

  factory TeacherRequestModel.fromJson(final Map<String, dynamic> json) =>
      _$TeacherRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherRequestModelToJson(this);

  @JsonKey(name: "Bio")
  final String bio;
}
