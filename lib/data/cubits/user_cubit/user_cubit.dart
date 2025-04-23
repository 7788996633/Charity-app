// ignore_for_file: avoid_print

import 'package:baader/data/cubits/user_role_cubit/user_role_cubit.dart';
import 'package:baader/data/models/usermodel.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../repository/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRoleCubit userRoleCubit;

  UserCubit(this.userRoleCubit) : super(UserInitial());

  void getUserInfo(UserRoleCubit userRoleCubit) {
    emit(UserLoading());
    try {
      UserRepository().showUserInfo().then(
        (value) {
          emit(UserSuccess(userModel: value));
          final String role = value.role;
          print("===================================================");
          print(role);
          userRoleCubit.setUserRole(role);
        },
      );
    } on Exception catch (e) {
      emit(UserFail(errmsg: e.toString()));
    }
  }
}
