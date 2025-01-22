import "package:json_annotation/json_annotation.dart";

part "meeting_history_net_model.g.dart";

@JsonSerializable()
class MeetingsHistoryNetModel {
  MeetingsHistoryNetModel({required this.history});

  factory MeetingsHistoryNetModel.fromJson(final Map<String, dynamic> json) => 
    _$MeetingsHistoryNetModelFromJson(json);

  final List<MeetingHistoryNetModel> history;
}

@JsonSerializable()
class MeetingHistoryNetModel {
  MeetingHistoryNetModel({
    required this.subject,
    required this.prtnerName,
    required this.startTime,
    required this.endTime,
  });

  factory MeetingHistoryNetModel.fromJson(final Map<String, dynamic> json) => 
    _$MeetingHistoryNetModelFromJson(json);

  final String subject;
  final String prtnerName;
  final String startTime;
  final String endTime;
}

