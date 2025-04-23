import 'package:baader/data/cubits/delete_article_cubit/delete_article_cubit.dart';
import 'package:baader/data/models/articlemodel.dart';
import 'package:baader/presentaion/widgets/add_Article_sheet.dart';
import 'package:baader/presentaion/widgets/Article_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminArticlesView extends StatelessWidget {
  const AdminArticlesView({super.key, required this.articles});
  final List<ArticleModel> articles;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<DeleteArticleCubit, DeleteArticleState>(
        listener: (context, state) {
          if (state is DeleteArticleSuccess) {
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
          } else if (state is DeleteArticleFail) {
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
                itemCount: articles.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ArticleItem(
                        currArticle: articles[index],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () {
                              // Add edit functionality here
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            onPressed: () {
                              BlocProvider.of<DeleteArticleCubit>(context)
                                  .deleteArticle(articles[index].id);
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showBottomSheet(
                      backgroundColor: const Color.fromARGB(255, 38, 31, 125),
                      context: context,
                      builder: (context) => const AddArticleSheet());
                },
                icon: const Icon(Icons.add),
                label: const Text("Add New Articles"),
              ),
            ],
          );
        },
      ),
    );
  }
}
