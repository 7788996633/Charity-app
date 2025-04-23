// ignore_for_file: file_names

import 'package:baader/presentaion/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

import '../../data/models/articlemodel.dart';
import '../screens/articles/article_detail_screen.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({super.key, required this.currArticle});
  final ArticleModel currArticle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ArticleDetailScreen(
                  article: currArticle,
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
                    currArticle.image!,
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  children: [
                    CustomListTile(
                      maxlines: 1,
                      icon: const Icon(
                        Icons.title,
                        color: Colors.white,
                        size: 25,
                      ),
                      title: '${currArticle.title} ',
                    ),
                    // CustomListTile(
                    //   maxlines: 2,
                    //   icon: const Icon(
                    //     Icons.description,
                    //     color: Colors.white,
                    //     size: 25,
                    //   ),
                    //   title: '${currArticle.description} ',
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    );
  }
}
