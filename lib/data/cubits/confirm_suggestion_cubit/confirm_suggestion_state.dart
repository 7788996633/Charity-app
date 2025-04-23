part of 'confirm_suggestion_cubit.dart';

@immutable
sealed class ConfirmSuggestionState {}

final class ConfirmSuggestionInitial extends ConfirmSuggestionState {}

final class ConfirmSuggestionSuccess extends ConfirmSuggestionState {
  final String successmsg;

  ConfirmSuggestionSuccess({required this.successmsg});
}

final class ConfirmSuggestionLoadnig extends ConfirmSuggestionState {}

final class ConfirmSuggestionFail extends ConfirmSuggestionState {
  final String errmsg;

  ConfirmSuggestionFail({required this.errmsg});
}
