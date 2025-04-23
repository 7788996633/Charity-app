import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/coursemodel.dart';
import '../../repository/courses_repository.dart';

part 'show_hot_corses_state.dart';

class ShowHotCorsesCubit extends Cubit<ShowHotCorsesState> {
  ShowHotCorsesCubit() : super(ShowHotCorsesInitial());

  void showHotCourses() {
    emit(
      ShowHotCoursesLoading(),
    );
    try {
      CoursesRepository().showHotCourses().then(
        (value) {
          emit(
            ShowHotCoursesSuccess(courses: value),
          );
        },
      );
    } on Exception catch (e) {
      emit(
        ShowHotCoursesFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
