part of 'unsave_article_cubit.dart';

@immutable
sealed class UnsaveArticleState {}

final class UnsaveArticleInitial extends UnsaveArticleState {}

final class UnsaveArticleLoading extends UnsaveArticleState {}

final class UnsaveArticleSuccess extends UnsaveArticleState {
  final String successmsg;

  UnsaveArticleSuccess({required this.successmsg});
}

final class UnsaveArticleFail extends UnsaveArticleState {
  final String errmsg;

  UnsaveArticleFail({required this.errmsg});
}
