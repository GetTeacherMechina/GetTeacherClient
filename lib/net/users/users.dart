import "package:getteacher/net/net.dart";
import "package:json_annotation/json_annotation.dart";

part 'users.g.dart';

Future<List<UserDetails>> getAllUsersExcludingSelf() async {
  final Map<String, dynamic> data = await getClient().getJson("/users");

  return (data["users"] as List<dynamic>)
      .map((final a) => UserDetails.fromJson(a as Map<String, dynamic>))
      .toList();
}

@JsonSerializable()
class UserDetails {
  UserDetails({
    required this.user,
    this.student,
    this.teacher,
  });
  factory UserDetails.fromJson(final Map<String, dynamic> data) =>
      _$UserDetailsFromJson(data);

  final DbUser user;
  final DbStudent? student;
  final DbTeacher? teacher;

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}

@JsonSerializable()
class DbUser {
  DbUser({
    required this.id,
    required this.userName,
  });
  factory DbUser.fromJson(final Map<String, dynamic> data) =>
      _$DbUserFromJson(data);

  int id;
  String userName;

  Map<String, dynamic> toJson() => _$DbUserToJson(this);
}

@JsonSerializable()
class DbStudent {
  DbStudent({
    required this.id,
  });
  factory DbStudent.fromJson(final Map<String, dynamic> data) =>
      _$DbStudentFromJson(data);

  int id;

  Map<String, dynamic> toJson() => _$DbStudentToJson(this);
}

@JsonSerializable()
class DbTeacher {
  DbTeacher({
    required this.id,
    required this.bio,
    required this.numOfMeetings,
    required this.numOfRankers,
    required this.rank,
  });
  factory DbTeacher.fromJson(final Map<String, dynamic> data) =>
      _$DbTeacherFromJson(data);

  int id;
  String bio;
  int? numOfRankers;
  double? rank;
  int? numOfMeetings;

  Map<String, dynamic> toJson() => _$DbTeacherToJson(this);
}
