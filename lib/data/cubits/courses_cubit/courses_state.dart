part of 'courses_cubit.dart';

@immutable
sealed class CoursesState {}

final class CoursesInitial extends CoursesState {}

final class CoursesLoading extends CoursesState {}

final class CoursesSuccess extends CoursesState {
  final List<CourseModel> courses;

  CoursesSuccess({required this.courses});
}

final class CoursesFail extends CoursesState {
  final String errmsg;

  CoursesFail({required this.errmsg});
}
