import 'package:baader/data/services/suggestions_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'confirm_suggestion_state.dart';

class ConfirmSuggestionCubit extends Cubit<ConfirmSuggestionState> {
  ConfirmSuggestionCubit() : super(ConfirmSuggestionInitial());

  void confirmSuggestion(int suggId) {
    emit(
      ConfirmSuggestionLoadnig(),
    );
    try {
      SuggestionsServices().confirmSugg(suggId).then(
            (value) => emit(
              ConfirmSuggestionSuccess(successmsg: value),
            ),
          );
    } on Exception catch (e) {
      ConfirmSuggestionFail(
        errmsg: e.toString(),
      );
    }
  }
}
