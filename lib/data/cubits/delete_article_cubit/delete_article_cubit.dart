import 'package:baader/data/services/articlrs_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_article_state.dart';

class DeleteArticleCubit extends Cubit<DeleteArticleState> {
  DeleteArticleCubit() : super(DeleteArticleInitial());
  void deleteArticle(int articleId) {
    emit(
      DeleteArticleLoading(),
    );

    try {
      ArticlesServices().deleteArticle(articleId).then(
            (value) => emit(
              DeleteArticleSuccess(successmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        DeleteArticleFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
