part of 'add_suggestion_cubit.dart';

@immutable
sealed class AddSuggestionState {}

final class AddSuggestionInitial extends AddSuggestionState {}

final class AddSuggestionSuccess extends AddSuggestionState {
  final String successmsg;

  AddSuggestionSuccess({required this.successmsg});
}

final class AddSuggestionLoading extends AddSuggestionState {}

final class AddSuggestionFail extends AddSuggestionState {
  final String errmsg;

  AddSuggestionFail({required this.errmsg});
}
