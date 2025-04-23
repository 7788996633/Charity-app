import 'package:baader/data/repository/articles_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/saved_article_model.dart';

part 'show_saved_article_state.dart';

class ShowSavedArticleCubit extends Cubit<ShowSavedArticleState> {
  ShowSavedArticleCubit() : super(ShowSavedArticleInitial());

  void showSavedArticle() {
    emit(
      ShowSavedArticleLoading(),
    );
    try {
      ArticlesRepository().showSavedArticles().then(
            (value) => emit(
              ShowSavedArticleSuccess(art: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        ShowSavedArticleFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
