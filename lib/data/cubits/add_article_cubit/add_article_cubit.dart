import 'dart:io';

import 'package:baader/data/services/articlrs_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_article_state.dart';

class AddArticleCubit extends Cubit<AddArticleState> {
  AddArticleCubit() : super(AddArticleInitial());
  void addArticle(
      String title, String desc, String category, File selectedImage) {
    emit(
      AddArticleLoading(),
    );

    try {
      ArticlesServices().addArticle(title, desc, category, selectedImage).then(
            (value) => emit(
              AddArticleSuccess(successmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        AddArticleFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
