part of 'add_course_cubit.dart';

@immutable
sealed class AddCourseState {}

final class AddCourseInitial extends AddCourseState {}

final class AddCourseSuccess extends AddCourseState {
  final String successmsg;

  AddCourseSuccess({required this.successmsg});
}

final class AddCourseLoading extends AddCourseState {}

final class AddCourseFail extends AddCourseState {
  final String errmsg;

  AddCourseFail({required this.errmsg});
}
