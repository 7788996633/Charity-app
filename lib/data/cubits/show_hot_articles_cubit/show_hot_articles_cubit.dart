import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/articlemodel.dart';
import '../../repository/articles_repository.dart';

part 'show_hot_articles_state.dart';

class ShowHotArticlesCubit extends Cubit<ShowHotArticlesState> {
  ShowHotArticlesCubit() : super(ShowHotArticlesInitial());

  void showHotArticles() {
    emit(
      ShowHotArticlesLoading(),
    );
    try {
      ArticlesRepository().showHotArticles().then(
        (value) {
          emit(
            ShowHotArticlesSuccess(art: value),
          );
        },
      );
    } on Exception catch (e) {
      emit(
        ShowHotArticlesFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
