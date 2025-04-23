part of 'edit_article_cubit.dart';

@immutable
sealed class EditArticleState {}

final class EditArticleInitial extends EditArticleState {}

final class EditArticleSuccess extends EditArticleState {
  final String successmsg;

  EditArticleSuccess({required this.successmsg});
}

final class EditArticleFail extends EditArticleState {
  final String errmsg;

  EditArticleFail({required this.errmsg});
}

final class EditArticleLoading extends EditArticleState {}
