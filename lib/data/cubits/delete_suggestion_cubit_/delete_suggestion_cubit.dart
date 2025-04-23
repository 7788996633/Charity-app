import 'package:baader/data/services/suggestions_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_suggestion_state.dart';

class DeleteSuggestionCubit extends Cubit<DeleteSuggestionState> {
  DeleteSuggestionCubit() : super(DeleteSuggestionInitial());
  void deleteSugg(int id) {
    emit(
      DeleteSuggestionLoading(),
    );
    try {
      SuggestionsServices().deleteSugg(id).then(
            (value) => emit(
              DeleteSuggestionSuccess(
                successmsg: value,
              ),
            ),
          );
    } on Exception catch (e) {
      emit(
        DeleteSuggestionFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
