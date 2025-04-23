part of 'articles_cubit.dart';

@immutable
sealed class ArticlesState {}

final class ArticlesInitial extends ArticlesState {}
final class ArticleSuccess extends ArticlesState {
  final List<ArticleModel> art;

  ArticleSuccess({required this.art});
}

final class ArticleLoading extends ArticlesState {}

final class ArticleFail extends ArticlesState {
  final String errmsg;

  ArticleFail({required this.errmsg});
}
