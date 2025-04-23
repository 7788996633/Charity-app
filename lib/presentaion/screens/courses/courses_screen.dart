import 'package:baader/data/cubits/user_cubit/user_cubit.dart';
import 'package:baader/presentaion/screens/courses/admin_courses__screen.dart';
import 'package:baader/presentaion/widgets/course_item.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:baader/presentaion/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/cubits/courses_cubit/courses_cubit.dart';
import '../../../data/cubits/user_role_cubit/user_role_cubit.dart';
import '../../../data/models/coursemodel.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  late List<CourseModel> coursesList;
  late UserRoleCubit userRoleCubit;

  @override
  void initState() {
    super.initState();
    userRoleCubit = UserRoleCubit();
    BlocProvider.of<UserCubit>(context).getUserInfo(userRoleCubit);
    BlocProvider.of<CoursesCubit>(context).showCourses();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        if (state is CoursesSuccess) {
          coursesList = state.courses;
          return BlocBuilder<UserRoleCubit, UserRoleState>(
            builder: (context, roleState) {
              if (roleState is UserRoleSuperAdmin ||
                  roleState is UserRoleAdmin) {
                return const AdminCoursesView();
              } else if (roleState is UserRoleNormal ||
                  roleState is UserRoleVolunteer) {
                return buildcoursesList();
              } else {
                return const Center(
                  child: CustomLoadingIndicator(),
                );
              }
            },
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

  Widget buildcoursesList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            itemCount: coursesList.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) => Column(
              children: [
                CourseItem(
                  courseModel: coursesList[index],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserRoleCubit>.value(
      value: userRoleCubit,
      child: CustomScaffold(
        appBarActions: IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {
            showSearch(
              context: context,
              delegate: CoursesearchDelegate(coursesList),
            );
          },
        ),
        appBarTitle: "Courses",
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: buildBlocWidget(),
        ),
      ),
    );
  }
}

class CoursesearchDelegate extends SearchDelegate {
  final List<CourseModel> courses;

  CoursesearchDelegate(this.courses);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 21, 8, 40),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Colors.white),
      ),
      cardColor: Colors.white,
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = courses
        .where(
            (course) => course.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 21, 8, 40),
            Color.fromARGB(255, 9, 5, 56),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return CourseItem(courseModel: results[index]);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = courses
        .where(
            (course) => course.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 21, 8, 40),
            Color.fromARGB(255, 9, 5, 56),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              suggestions[index].name,
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
            onTap: () {
              query = suggestions[index].name;
              showResults(context);
            },
          );
        },
      ),
    );
  }
}
