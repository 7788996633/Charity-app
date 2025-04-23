import 'package:baader/data/models/eventmodel.dart';
import 'package:baader/data/services/events_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_event_by_id_state.dart';

class ShowEventByIdCubit extends Cubit<ShowEventByIdState> {
  ShowEventByIdCubit() : super(ShowEventByIdInitial());
  void getEvent(int userId) {
    emit(
      ShowEventByIdLoading(),
    );
    try {
      EventsServices().getEventById(userId).then(
            (value) => emit(
              ShowEventByIdSuccess(ev: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        ShowEventByIdFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
