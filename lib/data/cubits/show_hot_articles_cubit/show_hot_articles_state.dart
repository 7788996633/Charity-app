part of 'show_hot_articles_cubit.dart';

@immutable
sealed class ShowHotArticlesState {}

final class ShowHotArticlesInitial extends ShowHotArticlesState {}

final class ShowHotArticlesSuccess extends ShowHotArticlesState {
  final List<ArticleModel> art;

  ShowHotArticlesSuccess({required this.art});
}

final class ShowHotArticlesLoading extends ShowHotArticlesState {}

final class ShowHotArticlesFail extends ShowHotArticlesState {
  final String errmsg;

  ShowHotArticlesFail({required this.errmsg});
}
