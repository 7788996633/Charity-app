import 'package:baader/data/services/login_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginCubit(String email, String password) async {
    emit(LoginLoading());
    try {
      final token = await LoginService().login(email, password);
      if (token != 'fail') {
        emit(LoginSuccess(token: token));
      } else {
        emit(LoginFail(errmsg: token));
      }
    } on Exception catch (e) {
      emit(LoginFail(errmsg: e.toString()));
    }
  }
}
