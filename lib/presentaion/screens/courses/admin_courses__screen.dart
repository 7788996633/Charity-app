import 'package:baader/data/cubits/courses_cubit/courses_cubit.dart';
import 'package:baader/data/cubits/delete_course_cubit/delete_course_cubit.dart';
import 'package:baader/presentaion/widgets/add_Course_sheet.dart';
import 'package:baader/presentaion/widgets/course_item.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCoursesView extends StatelessWidget {
  const AdminCoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        if (state is CoursesSuccess) {
          final coursesList = state.courses;
          return SingleChildScrollView(
            child: BlocConsumer<DeleteCourseCubit, DeleteCourseState>(
              listener: (context, state) {
                if (state is DeleteCourseSuccess) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 146, 100, 239),
                      content: Text(
                        state.successmsg,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                } else if (state is DeleteCourseFail) {
                  Navigator.of(context).pop(); // Close the loading dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 146, 100, 239),
                      content: Text(
                        state.errmsg,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    ListView.builder(
                      itemCount: coursesList.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CourseItem(
                              courseModel: coursesList[index],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.white),
                                  onPressed: () {
                                    // Add edit functionality here
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.white),
                                  onPressed: () {
                                    BlocProvider.of<DeleteCourseCubit>(context)
                                        .deleteCourse(coursesList[index].id);
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        showBottomSheet(
                            backgroundColor:
                                const Color.fromARGB(255, 38, 31, 125),
                            context: context,
                            builder: (context) => const AddCourseSheet());
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Add New Courses"),
                    ),
                  ],
                );
              },
            ),
          );
        } else if (state is CoursesFail) {
          return Column(
            children: [
              const Text(
                "There is an error:",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                state.errmsg,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CustomLoadingIndicator(),
          );
        }
      },
    );
  }
}
