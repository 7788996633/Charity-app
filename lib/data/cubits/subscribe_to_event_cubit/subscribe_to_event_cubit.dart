import 'package:baader/data/services/events_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'subscribe_to_event_state.dart';

class SubscribeToEventCubit extends Cubit<SubscribeToEventState> {
  SubscribeToEventCubit() : super(SubscribeToEventInitial());
  void subscribeToEventAsABen(int eventID) {
    emit(
      SubscribeToEventLoading(),
    );
    try {
      EventsServices().subscribeToEventAsABen(eventID).then(
            (value) => emit(
              SubscribeToEventSuccess(sucssessmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        SubscribeToEventFail(
          errmsg: e.toString(),
        ),
      );
    }
  }

  void subscribeToEventAsAVol(int eventID) {
    emit(
      SubscribeToEventLoading(),
    );
    try {
      EventsServices().subscribeToEventAsAVolunteer(eventID).then(
            (value) => emit(
              SubscribeToEventSuccess(sucssessmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        SubscribeToEventFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
