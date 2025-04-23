part of 'suggestions_cubit.dart';

@immutable
sealed class SuggestionsState {}

final class SuggestionsInitial extends SuggestionsState {}

final class SuggestionsSuccess extends SuggestionsState {
  final List<SuggestionModel> suggestions;

  SuggestionsSuccess({required this.suggestions});
}

final class SuggestionsLoading extends SuggestionsState {}

final class SuggestionsFail extends SuggestionsState {
  final String errmsg;

  SuggestionsFail({required this.errmsg});
}
