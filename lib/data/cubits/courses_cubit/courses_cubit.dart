import 'package:baader/data/repository/courses_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/coursemodel.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInitial());

  void showCourses() {
    emit(
      CoursesLoading(),
    );

    try {
      CoursesRepository().showCourses().then(
        (value) {
          emit(
            CoursesSuccess(courses: value),
          );
        },
      );
    } on Exception catch (e) {
      emit(
        CoursesFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
