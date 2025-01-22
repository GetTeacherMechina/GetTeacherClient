import "package:json_annotation/json_annotation.dart";

part "meeting_history_net_model.g.dart";

@JsonSerializable()
class MeetingsHistoryNetModelRequst {
  MeetingsHistoryNetModelRequst({required this.history});

  factory MeetingsHistoryNetModelRequst.fromJson(
          final Map<String, dynamic> json) =>
      _$MeetingsHistoryNetModelRequstFromJson(json);

  final List<MeetingHistoryNetModelRequst> history;
}

@JsonSerializable()
class MeetingHistoryNetModelRequst {
  MeetingHistoryNetModelRequst({
    required this.subject,
    required this.prtnerName,
    required this.startTime,
    required this.endTime,
  });

  factory MeetingHistoryNetModelRequst.fromJson(
          final Map<String, dynamic> json) =>
      _$MeetingHistoryNetModelRequstFromJson(json);

  final String subject;
  final String prtnerName;
  final String startTime;
  final String endTime;
}

@JsonSerializable()
class MeetingsHistoryNetModelRespons {
  MeetingsHistoryNetModelRespons(
      {required this.isStudent, required this.isTeacher});

  Map<String, dynamic> toJson() => _$MeetingsHistoryNetModelResponsToJson(this);

  final bool isTeacher;
  final bool isStudent;
}
