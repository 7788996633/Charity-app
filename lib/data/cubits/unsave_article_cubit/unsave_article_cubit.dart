import 'package:baader/data/services/articlrs_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'unsave_article_state.dart';

class UnsaveArticleCubit extends Cubit<UnsaveArticleState> {
  UnsaveArticleCubit() : super(UnsaveArticleInitial());
  void unSaveArticle(int id) {
    emit(
      UnsaveArticleLoading(),
    );
    try {
      ArticlesServices().unSaveArticle(id).then(
            (value) => emit(
              UnsaveArticleSuccess(
                successmsg: value,
              ),
            ),
          );
    } on Exception catch (e) {
      emit(
        UnsaveArticleFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
