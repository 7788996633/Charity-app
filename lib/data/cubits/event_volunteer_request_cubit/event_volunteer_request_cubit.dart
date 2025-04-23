import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/benifit_request_model.dart';
import '../../repository/events_repository.dart';

part 'event_volunteer_request_state.dart';

class EventVolunteerRequestCubit extends Cubit<EventVolunteerRequestState> {
  EventVolunteerRequestCubit() : super(EventVolunteerRequestInitial());
  void showVolList(int eventId) {
    emit(
      EventVolunteerRequestLoading(),
    );
    try {
      EventsRepository().showVolunteerRequest(eventId).then(
            (value) => emit(
              EventVolunteerRequestSuccess(reqs: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        EventVolunteerRequestFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
