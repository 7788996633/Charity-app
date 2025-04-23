import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/cubits/articles_cubit/articles_cubit.dart';
import '../../../data/cubits/user_cubit/user_cubit.dart';
import '../../../data/cubits/user_role_cubit/user_role_cubit.dart';
import '../../../data/models/articlemodel.dart';
import '../../widgets/article_item.dart';
import '../../widgets/custom_loading_indicator.dart';
import '../../widgets/custom_scaffold.dart';
import 'admin_articles_view.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  late UserRoleCubit userRoleCubit;
  late List<ArticleModel> articlesList = [];
  late List<ArticleModel> showedArticles = [];
  String selectedFilter = "All";

  @override
  void initState() {
    super.initState();
    userRoleCubit = UserRoleCubit();
    BlocProvider.of<UserCubit>(context).getUserInfo(userRoleCubit);
    BlocProvider.of<ArticlesCubit>(context).getAllArticles();
  }

  void filterRequests(String filter) {
    setState(() {
      selectedFilter = filter;
      if (filter == "All") {
        showedArticles = articlesList;
      } else if (filter == "Medical") {
        showedArticles = articlesList
            .where((element) => element.category == 'Medical')
            .toList();
      } else if (filter == "Family") {
        showedArticles = articlesList
            .where((element) => element.category == 'Family')
            .toList();
      } else if (filter == "Business") {
        showedArticles = articlesList
            .where((element) => element.category == 'Business')
            .toList();
      } else if (filter == "Social") {
        showedArticles = articlesList
            .where((element) => element.category == 'Social')
            .toList();
      }
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<ArticlesCubit, ArticlesState>(
      builder: (context, state) {
        if (state is ArticleSuccess) {
          articlesList = state.art;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            filterRequests(selectedFilter);
          });

          return BlocBuilder<UserRoleCubit, UserRoleState>(
            builder: (context, roleState) {
              if (roleState is UserRoleSuperAdmin ||
                  roleState is UserRoleAdmin) {
                return AdminArticlesView(
                  articles: showedArticles,
                );
              } else if (roleState is UserRoleNormal ||
                  roleState is UserRoleVolunteer) {
                return buildArticlesList();
              } else {
                return const Center(
                  child: CustomLoadingIndicator(),
                );
              }
            },
          );
        } else if (state is ArticleFail) {
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

  Widget buildArticlesList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            itemCount: showedArticles.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) => ArticleItem(
              currArticle: showedArticles[index],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
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
        appBarActions: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ArticleSearchDelegate(articlesList),
                );
              },
            ),
            PopupMenuButton<String>(
              color: const Color.fromARGB(255, 60, 53, 104),
              onSelected: filterRequests,
              icon: const Icon(
                Icons.filter_list,
                color: Colors.white,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'All',
                  child: Text(
                    "All",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 'Family',
                  child: Text(
                    "Family",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 'Medical',
                  child: Text(
                    "Medical",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 'Business',
                  child: Text(
                    "Business",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        appBarTitle: "Articles",
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: buildBlocWidget(),
        ),
      ),
    );
  }
}

class ArticleSearchDelegate extends SearchDelegate {
  final List<ArticleModel> articles;

  ArticleSearchDelegate(this.articles);
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
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.white),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = articles
        .where((article) =>
            article.title.toLowerCase().contains(query.toLowerCase()))
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
          return ArticleItem(currArticle: results[index]);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = articles
        .where((article) =>
            article.title.toLowerCase().contains(query.toLowerCase()))
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
              suggestions[index].title,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            onTap: () {
              query = suggestions[index].title;
              showResults(context);
            },
          );
        },
      ),
    );
  }
}
