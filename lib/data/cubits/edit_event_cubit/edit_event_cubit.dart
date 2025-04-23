import 'dart:io';

import 'package:baader/data/services/events_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_event_state.dart';

class EditEventCubit extends Cubit<EditEventState> {
  EditEventCubit() : super(EditEventInitial());

  void editEvent(
    int eventId,
    String name,
    String desc,
    // String startdate,
    // String enddate,
    String location,
    File? image,
  ) {
    emit(
      EditEventLoading(),
    );
    try {
      EventsServices()
          .updateEvent(
            eventId,
            name,
            desc,
            // startdate,
            // enddate,
            location, image,
          )
          .then(
            (value) => emit(
              EditEventSuccess(
                successmsg: value,
              ),
            ),
          );
    } on Exception catch (e) {
      emit(
        EditEventFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
