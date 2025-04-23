import 'package:baader/data/models/coursemodel.dart';
import 'package:baader/data/services/course_services.dart';

class CoursesRepository {
  Future<List<CourseModel>> showCourses() async {
    var coursesList = await CourseServices().showCourses();
    return coursesList
        .map(
          (e) => CourseModel.fromJson(e),
        )
        .toList();
  }

  Future<List<CourseModel>> showHotCourses() async {
    var coursesList = await CourseServices().showHotCourses();
    return coursesList
        .map(
          (e) => CourseModel.fromJson(e),
        )
        .toList();
  }
}
