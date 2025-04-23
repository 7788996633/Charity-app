import 'dart:io';

import 'package:baader/data/services/events_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_events_state.dart';

class AddEventsCubit extends Cubit<AddEventsState> {
  AddEventsCubit() : super(AddEventsInitial());

  void addEvent(String name, String desc, String startdate, String enddate,
      String location, File selectedImage) {
    emit(
      AddEventsLoading(),
    );
    try {
      EventsServices()
          .addEvent(name, desc, startdate, enddate, location, selectedImage)
          .then(
            (value) => emit(
              AddEventsSuccess(successmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        AddEventsFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
