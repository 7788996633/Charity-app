import 'package:baader/data/repository/suggestions_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/suggestionmodel.dart';

part 'show_accepted_suggestions_state.dart';

class ShowAcceptedSuggestionsCubit extends Cubit<ShowAcceptedSuggestionsState> {
  ShowAcceptedSuggestionsCubit() : super(ShowAcceptedSuggestionsInitial());
  void showAcceptedSuggestions() {
    emit(
      ShowAcceptedSuggestionsLoading(),
    );
    try {
      SuggestionsRepository().showAcceptedSuggestions().then(
            (value) => emit(
              ShowAcceptedSuggestionsSuccess(
                suggs: value,
              ),
            ),
          );
    } on Exception catch (e) {
      emit(
        ShowAcceptedSuggestionsFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
