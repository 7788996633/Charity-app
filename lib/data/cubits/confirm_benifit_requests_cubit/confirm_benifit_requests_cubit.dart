import 'package:baader/data/services/events_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'confirm_benifit_requests_state.dart';

class ConfirmEventRequestsCubit extends Cubit<ConfirmEventRequestsState> {
  ConfirmEventRequestsCubit() : super(ConfirmEventRequestsInitial());

  void confirmBenReq(int reqId) {
    emit(
      ConfirmEventRequestsLoading(),
    );
    try {
      EventsServices().confirmBenReq(reqId).then(
            (value) => emit(
              ConfirmEventRequestsSuccess(successmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        ConfirmEventRequestsFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
  
    void confirmVolReq(int reqId) {
    emit(
      ConfirmEventRequestsLoading(),
    );
    try {
      EventsServices().confirmVolReq(reqId).then(
            (value) => emit(
              ConfirmEventRequestsSuccess(successmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        ConfirmEventRequestsFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
