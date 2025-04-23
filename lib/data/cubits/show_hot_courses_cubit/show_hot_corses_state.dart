part of 'show_hot_corses_cubit.dart';

@immutable
sealed class ShowHotCorsesState {}

final class ShowHotCorsesInitial extends ShowHotCorsesState {}

final class ShowHotCoursesSuccess extends ShowHotCorsesState {
  final List<CourseModel> courses;

  ShowHotCoursesSuccess({required this.courses});
}

final class ShowHotCoursesLoading extends ShowHotCorsesState {}

final class ShowHotCoursesFail extends ShowHotCorsesState {
  final String errmsg;

  ShowHotCoursesFail({required this.errmsg});
}
