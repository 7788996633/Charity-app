import 'package:baader/data/services/help_request_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'confirm_help_request_state.dart';

class ConfirmHelpRequestCubit extends Cubit<ConfirmHelpRequestState> {
  ConfirmHelpRequestCubit() : super(ConfirmHelpRequestInitial());
  void confirmHelpRequest(int id) {
    emit(
      ConfirmHelpRequestLoading(),
    );
    try {
      HelpRequestServices().confirmHelpRequest(id).then(
            (value) => emit(
              ConfirmHelpRequestSuccess(
                successmsg: value,
              ),
            ),
          );
    } on Exception catch (e) {
      emit(
        ConfirmHelpRequestFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
