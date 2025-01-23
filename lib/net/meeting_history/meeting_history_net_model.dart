import "package:json_annotation/json_annotation.dart";

part "meeting_history_net_model.g.dart";

@JsonSerializable()
class MeetingsHistoryResponse {
  MeetingsHistoryResponse({required this.history});

  factory MeetingsHistoryResponse.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$MeetingsHistoryResponseFromJson(json);

  final List<Meeting> history;
}

@JsonSerializable()
class Meeting {
  Meeting({
    required this.subjectName,
    required this.partnerName,
    required this.startTime,
    required this.endTime,
  });

  factory Meeting.fromJson(final Map<String, dynamic> json) =>
      _$MeetingFromJson(json);

  final String subjectName;
  final String partnerName;
  final DateTime startTime;
  final DateTime endTime;
}

@JsonSerializable()
class MeetingsHistoryRequest {
  MeetingsHistoryRequest({
    required this.isStudent,
    required this.isTeacher,
  });

  Map<String, dynamic> toJson() => _$MeetingsHistoryRequestToJson(this);

  final bool isTeacher;
  final bool isStudent;
}
