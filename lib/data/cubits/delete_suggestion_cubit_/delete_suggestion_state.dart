part of 'delete_suggestion_cubit.dart';

@immutable
sealed class DeleteSuggestionState {}

final class DeleteSuggestionInitial extends DeleteSuggestionState {}

final class DeleteSuggestionLoading extends DeleteSuggestionState {}

final class DeleteSuggestionFail extends DeleteSuggestionState {
  final String errmsg;

  DeleteSuggestionFail({required this.errmsg});
}

final class DeleteSuggestionSuccess extends DeleteSuggestionState {
  final String successmsg;

  DeleteSuggestionSuccess({required this.successmsg});
}
