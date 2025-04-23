import 'package:baader/data/models/statistics_model.dart';
import 'package:baader/data/repository/statistics_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_stat_state.dart';

class ShowStatCubit extends Cubit<ShowStatState> {
  ShowStatCubit() : super(ShowStatInitial());

  void showSt() {
    emit(
      ShowStatLoading(),
    );
    try {
      StatisticsRepository().showStatistics().then(
            (value) => emit(
              ShowStatSuccess(st: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        ShowStatFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
