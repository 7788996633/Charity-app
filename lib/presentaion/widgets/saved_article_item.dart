import 'package:baader/data/cubits/show_saved_article_cubit/show_saved_article_cubit.dart';
import 'package:baader/data/cubits/unsave_article_cubit/unsave_article_cubit.dart';
import 'package:baader/data/models/saved_article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cubits/show_article_by_id_cubit/show_article_by_id_cubit.dart';
import '../screens/articles/article_detail_screen.dart';
import 'custom_list_tile.dart';
import 'custom_loading_indicator.dart';

class SavedArticleItem extends StatelessWidget {
  const SavedArticleItem({super.key, required this.currArticle});
  final SavedArticleModel currArticle;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShowArticleByIdCubit()..getArticle(currArticle.articleId),
      child: BlocBuilder<ShowArticleByIdCubit, ShowArticleByIdState>(
        builder: (context, state) {
          if (state is ShowArticleByIdSuccess) {
            final article = state.articleModel;
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ArticleDetailScreen(
                      article: article,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 31, 25, 107),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      child: Image.network(
                        width: double.infinity,
                        article.image!,
                        height: MediaQuery.of(context).size.height * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                    CustomListTile(
                      maxlines: 1,
                      icon: const Icon(
                        Icons.title,
                        color: Colors.white,
                        size: 25,
                      ),
                      title: '${article.title} ',
                    ),
                    CustomListTile(
                      maxlines: 2,
                      icon: const Icon(
                        Icons.description,
                        color: Colors.white,
                        size: 25,
                      ),
                      title: '${article.description} ',
                    ),
                    Center(
                      child:
                          BlocConsumer<UnsaveArticleCubit, UnsaveArticleState>(
                        listener: (context, state) {
                          if (state is UnsaveArticleSuccess) {
                            BlocProvider.of<ShowSavedArticleCubit>(context)
                                .showSavedArticle();
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor:
                                    const Color.fromARGB(255, 146, 100, 239),
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
                          } else if (state is UnsaveArticleFail) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor:
                                    const Color.fromARGB(255, 146, 100, 239),
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
                          return ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<UnsaveArticleCubit>(context)
                                  .unSaveArticle(currArticle.id);
                            },
                            child: const Text(
                              "Unsave",
                              style: TextStyle(fontSize: 25),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is ShowArticleByIdFail) {
            return Center(
              child: Text(state.errmsg),
            );
          } else {
            return const Center(
              child: CustomLoadingIndicator(),
            );
          }
        },
      ),
    );
  }
}
