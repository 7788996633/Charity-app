import 'package:baader/data/models/articlemodel.dart';
import 'package:baader/data/services/articlrs_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_article_by_id_state.dart';

class ShowArticleByIdCubit extends Cubit<ShowArticleByIdState> {
  ShowArticleByIdCubit() : super(ShowArticleByIdInitial());
  void getArticle(int articleId) {
    emit(
      ShowArticleByIdLoading(),
    );
    try {
      ArticlesServices().showArticleById(articleId).then(
            (value) => emit(
              ShowArticleByIdSuccess(articleModel: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        ShowArticleByIdFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
