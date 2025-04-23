import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/articlemodel.dart';
import '../../repository/articles_repository.dart';


part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  ArticlesCubit() : super(ArticlesInitial());

  void getAllArticles() {
    emit(
      ArticleLoading(),
    );
        try {
      ArticlesRepository().showArticles().then(
        (value) {
          emit(
            ArticleSuccess(art: value),
          );
        },
      );
    } on Exception catch (e) {
      emit(
        ArticleFail(
          errmsg: e.toString(),
        ),
      );
    }

  }

   void getArticlesByCategory(String category) {
    emit(ArticleLoading());
    try {
      List<ArticleModel> articles = []; 
      emit(ArticleSuccess(art:  articles));
    } catch (e) {
      emit(ArticleFail(errmsg: e.toString()));
    }
  }
}
