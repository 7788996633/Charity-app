import 'dart:io';

import 'package:baader/data/services/course_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_course_state.dart';

class EditCourseCubit extends Cubit<EditCourseState> {
  EditCourseCubit() : super(EditCourseInitial());
  void editCourse(
    int courseId,
    String name,
    String url,
    String desc,
    String discount,
    File? selectedImage,
  ) {
    emit(
      EditCourseLoading(),
    );
    try {
      CourseServices()
          .updateCourse(courseId, name, url, desc, discount, selectedImage)
          .then(
            (value) => emit(
              EditCourseSuccess(
                successmsg: value,
              ),
            ),
          );
    } on Exception catch (e) {
      emit(
        EditCourseFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
