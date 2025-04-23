part of 'show_accepted_suggestions_cubit.dart';

@immutable
sealed class ShowAcceptedSuggestionsState {}

final class ShowAcceptedSuggestionsInitial
    extends ShowAcceptedSuggestionsState {}

final class ShowAcceptedSuggestionsSuccess
    extends ShowAcceptedSuggestionsState {
  final List<SuggestionModel> suggs;

  ShowAcceptedSuggestionsSuccess({required this.suggs});
}

final class ShowAcceptedSuggestionsLoading
    extends ShowAcceptedSuggestionsState {}

final class ShowAcceptedSuggestionsFail extends ShowAcceptedSuggestionsState {
  final String errmsg;

  ShowAcceptedSuggestionsFail({required this.errmsg});
}
