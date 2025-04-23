import 'package:baader/data/repository/rate_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/rate_model.dart';

part 'show_user_rate_state.dart';

class ShowUserRateCubit extends Cubit<ShowUserRateState> {
  ShowUserRateCubit() : super(ShowUserRateInitial());
  void showRates(int userId) {
    emit(
      ShowUserRateLoading(),
    );
    try {
      RateRepository().showUserRate(userId).then(
            (value) => emit(
              ShowUserRateSuccess(rates: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        ShowUserRateFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
