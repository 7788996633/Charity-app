import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/suggestionmodel.dart';
import '../../repository/suggestions_repository.dart';

part 'suggestions_state.dart';

class SuggestionsCubit extends Cubit<SuggestionsState> {
  SuggestionsCubit() : super(SuggestionsInitial());

    void getAllSuggestions() {
    emit(
      SuggestionsLoading(),
    );
    try {
      SuggestionsRepository().showSuggestions().then(
        (value) {
          emit(
            SuggestionsSuccess(suggestions: value),
          );
        },
      );
    } on Exception catch (e) {
      emit(
        SuggestionsFail(
          errmsg: e.toString(),
        ),
      );
    }
  }

}
