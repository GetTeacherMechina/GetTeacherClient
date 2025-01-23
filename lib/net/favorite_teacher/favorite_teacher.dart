import "dart:async";
import "package:getteacher/net/favorite_teacher/favorite_teacher_net_model.dart";
import "package:getteacher/net/net.dart";

Future<void> addFavoriteTeacher(
  final FavouriteTeacherRequestModel request,
) async {
  await getClient().postJson(
    "/student/favoriteteachers/add",
    request.toJson(),
  );
}

Future<void> removeFavoriteTeacher(
  final FavouriteTeacherRequestModel request,
) async {
  await getClient().postJson(
    "/student/favoriteteachers/remove",
    request.toJson(),
  );
}

Future<GetFavouriteTeachersResponseModel> getFavoriteTeachers() async {
  final Map<String, dynamic> json =
      await getClient().getJson("/student/favoriteteachers");
  return GetFavouriteTeachersResponseModel.fromJson(json);
}
