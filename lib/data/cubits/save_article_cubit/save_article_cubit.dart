import 'package:baader/data/services/articlrs_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'save_article_state.dart';

class SaveArticleCubit extends Cubit<SaveArticleState> {
  SaveArticleCubit() : super(SaveArticleInitial());
  void saveArticle(int articleID) {
    emit(
      SaveArticleLoading(),
    );
    try {
      ArticlesServices().saveArticle(articleID).then(
            (value) => emit(
              SaveArticleSuccess(successmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        SaveArticleFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
