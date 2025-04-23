import 'package:baader/data/services/user_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_user_role_state.dart';

class ChangeUserRoleCubit extends Cubit<ChangeUserRoleState> {
  ChangeUserRoleCubit() : super(ChangeUserRoleInitial());

  void changeRole(int userId,String userRole) {
    emit(
      ChangeUserRoleLoading(),
    );
    try {
      UserServices().changeUserRole(userId, userRole);
      emit(ChangeUserRoleSuccess(),);
    } on Exception catch (e) {
      emit(
        ChangeUserRoleFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
