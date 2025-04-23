part of 'save_article_cubit.dart';

@immutable
sealed class SaveArticleState {}

final class SaveArticleInitial extends SaveArticleState {}

final class SaveArticleSuccess extends SaveArticleState {
  final String successmsg;

  SaveArticleSuccess({required this.successmsg});
}

final class SaveArticleLoading extends SaveArticleState {}

final class SaveArticleFail extends SaveArticleState {
  final String errmsg;

  SaveArticleFail({required this.errmsg});
}
