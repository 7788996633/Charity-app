import 'package:baader/data/services/statistics_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_statistics_state.dart';

class AddStatisticsCubit extends Cubit<AddStatisticsState> {
  AddStatisticsCubit() : super(AddStatisticsInitial());
  void addSt(int eventId, String desc) {
    emit(
      AddStatisticsLoading(),
    );
    try {
      StatisticsServices().addSt(eventId, desc).then(
            (value) => emit(
              AddStatisticsSuccess(
                successmsg: value.toString(),
              ),
            ),
          );
    } on Exception catch (e) {
      emit(
        AddStatisticsFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
