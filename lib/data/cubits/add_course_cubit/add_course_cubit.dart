import 'dart:io';

import 'package:baader/data/services/course_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_course_state.dart';

class AddCourseCubit extends Cubit<AddCourseState> {
  AddCourseCubit() : super(AddCourseInitial());
  void addCourse(
    String name,
    String url,
    String desc,
    String discount,
    File selectedImage,
  ) {
    emit(
      AddCourseLoading(),
    );
    try {
      CourseServices().addCourse(name, url, desc, discount, selectedImage).then(
            (value) => emit(
              AddCourseSuccess(successmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        AddCourseFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
