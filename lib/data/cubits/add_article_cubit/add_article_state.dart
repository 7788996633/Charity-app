part of 'add_article_cubit.dart';

@immutable
sealed class AddArticleState {}

final class AddArticleInitial extends AddArticleState {}

final class AddArticleSuccess extends AddArticleState {
  final String successmsg;

  AddArticleSuccess({required this.successmsg});
}

final class AddArticleLoading extends AddArticleState {}

final class AddArticleFail extends AddArticleState {
  final String errmsg;

  AddArticleFail({required this.errmsg});
}
