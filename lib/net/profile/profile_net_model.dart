import "package:json_annotation/json_annotation.dart";

part "profile_net_model.g.dart";

@JsonSerializable()
class ProfileResponseModel {
  ProfileResponseModel({
    this.email = "",
    this.fullName = "",
  });

  // Factory method to create an instance from JSON
  factory ProfileResponseModel.fromJson(final Map<String, dynamic> json) =>
      _$ProfileResponseModelFromJson(json);

  final String email;
  final String fullName;

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() => _$ProfileResponseModelToJson(this);
}
