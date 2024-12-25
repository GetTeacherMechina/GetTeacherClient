import "package:json_annotation/json_annotation.dart";


part "subject_search_net_model.g.dart";

@JsonSerializable()
class SubjectSearchRequestModel
{
  SubjectSearchRequestModel({ required this.subjectName });

  Map<String, dynamic> toJson() =>
      _$SubjectSearchRequestModelToJson(this);

  final String subjectName;
}

@JsonSerializable()
class SubjectModel
{
  SubjectModel({ required this.id, required this.name });

  factory SubjectModel.fromJson(final Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);

  final int id;
  final String name;
}

@JsonSerializable()
class SubjectSearchResponseModel
{
  SubjectSearchResponseModel({required this.subjects});
  factory SubjectSearchResponseModel.fromJson(final Map<String, dynamic> json) =>
      _$SubjectSearchResponseModelFromJson(json);

  final List<SubjectModel> subjects;
}
