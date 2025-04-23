import 'package:baader/data/services/course_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_course_state.dart';

class DeleteCourseCubit extends Cubit<DeleteCourseState> {
  DeleteCourseCubit() : super(DeleteCourseInitial());
  void deleteCourse(int courseId) {
    emit(
      DeleteCourseLoading(),
    );
    try {
      CourseServices().deleteCourse(courseId).then(
            (value) => emit(
              DeleteCourseSuccess(
                successmsg: value,
              ),
            ),
          );
    } on Exception catch (e) {
      emit(
        DeleteCourseFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
