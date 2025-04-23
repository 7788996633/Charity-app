import 'package:baader/data/cubits/show_saved_article_cubit/show_saved_article_cubit.dart';
import 'package:baader/data/models/saved_article_model.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/custom_scaffold.dart';
import '../../widgets/saved_article_item.dart';

class SavedArticlesScreen extends StatefulWidget {
  const SavedArticlesScreen({super.key});

  @override
  State<SavedArticlesScreen> createState() => _SavedArticlesScreenState();
}

class _SavedArticlesScreenState extends State<SavedArticlesScreen> {
  late List<SavedArticleModel> articlesList;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShowSavedArticleCubit>(context).showSavedArticle();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<ShowSavedArticleCubit, ShowSavedArticleState>(
      builder: (context, state) {
        if (state is ShowSavedArticleSuccess) {
          articlesList = state.art;
          if (articlesList.isNotEmpty) {
            return buildLoadedListWidgets();
          } else {
            return const Center(
              child: Text(
                "There is no data .",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            );
          }
        } else if (state is ShowSavedArticleFail) {
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

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: buildArticlesList(),
    );
  }

  Widget buildArticlesList() {
    return Column(
      children: [
        ListView.builder(
          itemCount: articlesList.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) => SavedArticleItem(
            currArticle: articlesList[index],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarActions: const Text(""),
      appBarTitle: "Saved Articles",
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: buildBlocWidget(),
      ),
    );
  }
}
