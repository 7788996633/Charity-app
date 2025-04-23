part of 'show_saved_article_cubit.dart';

@immutable
sealed class ShowSavedArticleState {}

final class ShowSavedArticleInitial extends ShowSavedArticleState {}

final class ShowSavedArticleSuccess extends ShowSavedArticleState {
  final List<SavedArticleModel> art;

  ShowSavedArticleSuccess({required this.art});
}

final class ShowSavedArticleLoading extends ShowSavedArticleState {}

final class ShowSavedArticleFail extends ShowSavedArticleState {
  final String errmsg;

  ShowSavedArticleFail({required this.errmsg});
}
