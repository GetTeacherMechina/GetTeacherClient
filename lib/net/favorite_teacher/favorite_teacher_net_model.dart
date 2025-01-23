import "package:json_annotation/json_annotation.dart";

part "favorite_teacher_net_model.g.dart";

@JsonSerializable()
class GetFavouriteTeachersResponseModel {
  GetFavouriteTeachersResponseModel({
    required this.favouriteTeachers,
  });
  factory GetFavouriteTeachersResponseModel.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$GetFavouriteTeachersResponseModelFromJson(json);

  @JsonKey(name: "favouriteTeachers")
  final List<TeacherNetModel> favouriteTeachers;

  Map<String, dynamic> toJson() =>
      _$GetFavouriteTeachersResponseModelToJson(this);
}

@JsonSerializable()
class FavouriteTeacherRequestModel {
  FavouriteTeacherRequestModel({
    required this.teacherUserId,
  });

  factory FavouriteTeacherRequestModel.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$FavouriteTeacherRequestModelFromJson(json);

  final int teacherUserId;

  Map<String, dynamic> toJson() => _$FavouriteTeacherRequestModelToJson(this);
}

@JsonSerializable()
class TeacherNetModel {
  TeacherNetModel({
    required this.id,
    required this.dbUser,
    required this.bio,
  });

  factory TeacherNetModel.fromJson(final Map<String, dynamic> json) =>
      _$TeacherNetModelFromJson(json);

  final int id;
  final String bio;

  final DBUser dbUser;
  String get fullName => dbUser.userName;

  Map<String, dynamic> toJson() => _$TeacherNetModelToJson(this);
}

@JsonSerializable()
class DBUser {
  DBUser({
    required this.id,
    required this.userName,
  });

  factory DBUser.fromJson(final Map<String, dynamic> json) =>
      _$DBUserFromJson(json);

  final int id;
  final String userName;

  Map<String, dynamic> toJson() => _$DBUserToJson(this);
}
