import "package:json_annotation/json_annotation.dart";

part "teacher_settings_model.g.dart";

@JsonSerializable()
class TeacherSettingsModel {
  const TeacherSettingsModel({
    required this.tariffPerMinute,
    required this.bio,
  });
  factory TeacherSettingsModel.fromJson(final Map<String, dynamic> json) =>
      _$TeacherSettingsModelFromJson(json);

  final double tariffPerMinute;
  final String bio;
}
