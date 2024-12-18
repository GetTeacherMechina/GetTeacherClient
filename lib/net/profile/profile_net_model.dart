import "package:json_annotation/json_annotation.dart";

part "profile_net_model.g.dart";

@JsonSerializable()
class ProfileResponseModel {
  ProfileResponseModel({
    required this.email,
    required this.fullName,
    required this.isStudent,
    required this.isTeacher,
  });

  factory ProfileResponseModel.fromJson(final Map<String, dynamic> json) =>
      _$ProfileResponseModelFromJson(json);

  final String email;
  final String fullName;
  final bool isStudent;
  final bool isTeacher;

  Map<String, dynamic> toJson() => _$ProfileResponseModelToJson(this);
}
