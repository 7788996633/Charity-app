import 'package:baader/data/services/statistics_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_statistic_state.dart';

class DeleteStatisticCubit extends Cubit<DeleteStatisticState> {
  DeleteStatisticCubit() : super(DeleteStatisticInitial());
  void deleteStatistic(int id) {
    emit(
      DeleteStatisticLoading(),
    );
    try {
      StatisticsServices().deleteSt(id).then(
            (value) => emit(
              DeleteStatisticSuccess(successmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        DeleteStatisticFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
