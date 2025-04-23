import 'package:baader/data/services/events_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_event_state.dart';

class DeleteEventCubit extends Cubit<DeleteEventState> {
  DeleteEventCubit() : super(DeleteEventInitial());
  void deleteEvent(int eventID) {
    emit(
      DeleteEventLoading(),
    );
    try {
      EventsServices().deleteEvent(eventID).then(
            (value) => emit(
              DeleteEventSuccess(successmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        DeleteEventFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
