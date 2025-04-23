import 'package:baader/data/cubits/show_hot_events_cubit/show_hot_events_cubit.dart';
import 'package:baader/data/models/coursemodel.dart';
import 'package:baader/data/models/eventmodel.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cubits/show_hot_articles_cubit/show_hot_articles_cubit.dart';
import '../../data/cubits/show_hot_courses_cubit/show_hot_corses_cubit.dart';
import '../../data/models/articlemodel.dart';
import 'article_item.dart';
import 'course_item.dart';
import 'event_item.dart';

class HotList extends StatefulWidget {
  const HotList({super.key});

  @override
  State<HotList> createState() => _HotListState();
}

class _HotListState extends State<HotList> {
  late List<ArticleModel> articlesList;
  late List<CourseModel> coursesList;
  late List<EventModel> eventsList;

  @override
  void initState() {
    BlocProvider.of<ShowHotEventsCubit>(context).showHotEvents();
    BlocProvider.of<ShowHotArticlesCubit>(context).showHotArticles();
    BlocProvider.of<ShowHotCorsesCubit>(context).showHotCourses();

    super.initState();
  }

  Widget buildArticlesList() {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context)
              .size
              .width, // تقييد العرض بناءً على حجم الشاشة
          child: GridView.builder(
            itemCount: articlesList.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1,
              crossAxisSpacing: 1,
            ),
            itemBuilder: (context, index) => ArticleItem(
              currArticle: articlesList[index],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget buildCoursesList() {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context)
              .size
              .width, // تقييد العرض بناءً على حجم الشاشة
          child: GridView.builder(
            itemCount: coursesList.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 0.8,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) => CourseItem(
              courseModel: coursesList[index],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget buildEventsList() {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context)
              .size
              .width, // تقييد العرض بناءً على حجم الشاشة
          child: GridView.builder(
            itemCount: eventsList.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 0.9,
              crossAxisSpacing: 1,
            ),
            itemBuilder: (context, index) => EventItem(
              currEvent: eventsList[index],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          BlocBuilder<ShowHotEventsCubit, ShowHotEventsState>(
            builder: (context, state) {
              if (state is ShowHotEventsuccess) {
                eventsList = state.ev;
                return buildEventsList();
              } else if (state is ShowHotAEventsFail) {
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
          ),
          const Divider(),
          BlocBuilder<ShowHotArticlesCubit, ShowHotArticlesState>(
            builder: (context, state) {
              if (state is ShowHotArticlesSuccess) {
                articlesList = state.art;
                return buildArticlesList();
              } else if (state is ShowHotArticlesFail) {
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
          ),
          const Divider(),
          BlocBuilder<ShowHotCorsesCubit, ShowHotCorsesState>(
            builder: (context, state) {
              if (state is ShowHotCoursesSuccess) {
                coursesList = state.courses;
                return buildCoursesList();
              } else if (state is ShowHotCoursesFail) {
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
          ),
        ],
      ),
    );
  }
}
