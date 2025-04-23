part of 'delete_article_cubit.dart';

@immutable
sealed class DeleteArticleState {}

final class DeleteArticleInitial extends DeleteArticleState {}

final class DeleteArticleSuccess extends DeleteArticleState {
  final String successmsg;

  DeleteArticleSuccess({required this.successmsg});
}

final class DeleteArticleLoading extends DeleteArticleState {}

final class DeleteArticleFail extends DeleteArticleState {
  final String errmsg;

  DeleteArticleFail({required this.errmsg});
}
