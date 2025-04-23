part of 'delete_course_cubit.dart';

@immutable
sealed class DeleteCourseState {}

final class DeleteCourseInitial extends DeleteCourseState {}

final class DeleteCourseSuccess extends DeleteCourseState {
  final String successmsg;

  DeleteCourseSuccess({required this.successmsg});
}

final class DeleteCourseFail extends DeleteCourseState {
  final String errmsg;

  DeleteCourseFail({required this.errmsg});
}

final class DeleteCourseLoading extends DeleteCourseState {}
