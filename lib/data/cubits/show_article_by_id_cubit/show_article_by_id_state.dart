part of 'show_article_by_id_cubit.dart';

@immutable
sealed class ShowArticleByIdState {}

final class ShowArticleByIdInitial extends ShowArticleByIdState {}

final class ShowArticleByIdSuccess extends ShowArticleByIdState {
  final ArticleModel articleModel;

  ShowArticleByIdSuccess({required this.articleModel});
}

final class ShowArticleByIdLoading extends ShowArticleByIdState {}

final class ShowArticleByIdFail extends ShowArticleByIdState {
  final String errmsg;

  ShowArticleByIdFail({required this.errmsg});
}
