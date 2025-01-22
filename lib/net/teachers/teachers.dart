import "package:getteacher/net/net.dart";
import "package:json_annotation/json_annotation.dart";

part 'teachers.g.dart';

Future<List<DbTeacher>> getAllTeachers() async {
  final data = await getClient().getJson("/teachers");

  return (data["teachers"] as List<dynamic>)
      .map((final a) => DbTeacher.fromJson(a as Map<String, dynamic>))
      .toList();
}

@JsonSerializable()
class DbTeacher {
  DbTeacher(
      {required this.bio,
      required this.id,
      required this.numOfMeetings,
      required this.numOfRankers,
      required this.rank,required this.userName});
  factory DbTeacher.fromJson(final Map<String, dynamic> data) =>
      _$DbTeacherFromJson(data);

  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "userName")
  String userName;

  @JsonKey(name: "bio")
  String bio;

  @JsonKey(name: "numOfRankers")
  int? numOfRankers;
  @JsonKey(name: "rank")
  double? rank;
  @JsonKey(name: "numOfMeetings")
  int? numOfMeetings;

  Map<String, dynamic> toJson() => _$DbTeacherToJson(this);
}
