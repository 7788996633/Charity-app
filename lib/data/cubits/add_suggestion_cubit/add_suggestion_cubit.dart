import 'package:baader/data/services/suggestions_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_suggestion_state.dart';

class AddSuggestionCubit extends Cubit<AddSuggestionState> {
  AddSuggestionCubit() : super(AddSuggestionInitial());

  void addSugg(String sugg) {
    emit(
      AddSuggestionLoading(),
    );
    try {
      SuggestionsServices().addSugg(sugg).then(
            (value) => emit(
              AddSuggestionSuccess(successmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        AddSuggestionFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
