import 'package:baader/data/services/logout_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  void logOut() {
    emit(
      LogoutLoading(),
    );
    try {
      LogOutService().logOut();
      emit(
        LogoutSuccess(),
      );
    } on Exception catch (e) {
      emit(
        LogoutFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
