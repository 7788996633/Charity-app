import 'package:baader/data/cubits/save_article_cubit/save_article_cubit.dart';
import 'package:baader/data/models/articlemodel.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_material_button.dart';
import 'package:baader/presentaion/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key, required this.article});
  final ArticleModel article;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SaveArticleCubit, SaveArticleState>(
      listener: (context, state) {
        if (state is SaveArticleSuccess) {
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
        } else if (state is SaveArticleFail) {
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
        return CustomScaffold(
          appBarActions: const Text(""),
          appBarTitle: article.title,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.5,
                    '${article.image}',
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CustomContainar(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.description,
                            color: Colors.white,
                          ),
                          title: Text(
                            article.description,
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(color: Colors.white54),
                        ListTile(
                          leading: const Icon(
                            Icons.category,
                            color: Colors.white,
                          ),
                          title: Text(
                            article.category,
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(color: Colors.white54),
                        CustomMaterialButton(
                          text: "Save",
                          onPressed: () {
                            BlocProvider.of<SaveArticleCubit>(context)
                                .saveArticle(article.id);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
