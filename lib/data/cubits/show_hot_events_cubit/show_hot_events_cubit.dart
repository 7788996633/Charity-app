import 'package:baader/data/models/eventmodel.dart';
import 'package:baader/data/repository/events_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_hot_events_state.dart';

class ShowHotEventsCubit extends Cubit<ShowHotEventsState> {
  ShowHotEventsCubit() : super(ShowHotEventsInitial());

  void showHotEvents() {
    emit(
      ShowHotAEventsLoading(),
    );
    try {
      EventsRepository().showHotEvents().then(
        (value) {
          emit(
            ShowHotEventsuccess(ev: value),
          );
        },
      );
    } on Exception catch (e) {
      emit(
        ShowHotAEventsFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
