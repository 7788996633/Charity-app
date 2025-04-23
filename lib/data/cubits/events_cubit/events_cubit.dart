import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/eventmodel.dart';
import '../../repository/events_repository.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit() : super(EventsInitial());
  void getAllEvents() {
    emit(
      EventLoading(),
    );
    try {
      EventsRepository().showEvents().then(
        (value) {
          emit(
            EventSuccess(ev: value),
          );
        },
      );
    } on Exception catch (e) {
      emit(
        EventFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
