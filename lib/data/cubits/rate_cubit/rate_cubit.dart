import 'package:baader/data/services/rating_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'rate_state.dart';

class RateCubit extends Cubit<RateState> {
  RateCubit() : super(RateInitial());

  void rate(int userId, String rate, String comment) {
    emit(
      RateLoading(),
    );
    try {
      RatingServices().rate(userId, rate, comment).then(
            (value) => emit(
              RateSuccess(successmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        RateFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
