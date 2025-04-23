part of 'edit_course_cubit.dart';

@immutable
sealed class EditCourseState {}

final class EditCourseInitial extends EditCourseState {}

final class EditCourseSuccess extends EditCourseState {
  final String successmsg;

  EditCourseSuccess({required this.successmsg});
}

final class EditCourseFail extends EditCourseState {
  final String errmsg;

  EditCourseFail({required this.errmsg});
}

final class EditCourseLoading extends EditCourseState {}
