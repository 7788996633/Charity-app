import 'package:baader/data/services/help_request_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_help_request_state.dart';

class DeleteHelpRequestCubit extends Cubit<DeleteHelpRequestState> {
  DeleteHelpRequestCubit() : super(DeleteHelpRequestInitial());
  void deleteHelpRequest(int id) {
    emit(
      DeleteHelpRequestLoading(),
    );
    try {
      HelpRequestServices().deleteHelpRequest(id).then(
            (value) => emit(
              DeleteHelpRequestSuccess(
                successmsg: value,
              ),
            ),
          );
    } on Exception catch (e) {
      emit(
        DeleteHelpRequestFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
