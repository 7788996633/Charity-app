import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/events_services.dart';

part 'delete_event_request_state.dart';

class DeleteEventRequestCubit extends Cubit<DeleteEventRequestState> {
  DeleteEventRequestCubit() : super(DeleteEventRequestInitial());
    void deleteBenReq(int reqId) {
    emit(
      DeleteEventRequestsLoading(),
    );
    try {
      EventsServices().deleteBenReq(reqId).then(
            (value) => emit(
              DeleteEventRequestsSuccess(successmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        DeleteEventRequestsFail(
          errmsg: e.toString(),
        ),
      );
    }
  }

  void deleteVolReq(int reqId) {
    emit(
      DeleteEventRequestsLoading(),
    );
    try {
      EventsServices().deleteVolReq(reqId).then(
            (value) => emit(
              DeleteEventRequestsSuccess(successmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        DeleteEventRequestsFail(
          errmsg: e.toString(),
        ),
      );
    }
  }

}
