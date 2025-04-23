// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_role_state.dart';

class UserRoleCubit extends Cubit<UserRoleState> {
  UserRoleCubit() : super(UserRoleInitial());
  void setUserRole(String role) {
    switch (role) {
      case 'superAdmin':
        emit(UserRoleSuperAdmin());
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        print(role);
        break;
      case 'admin':
        emit(UserRoleAdmin());
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

        print(role);
        break;
      case 'volunteer':
        emit(UserRoleVolunteer());
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

        print(role);
        break;
      case 'user':
        emit(UserRoleNormal());
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

        print(role);
        break;
    }
  }
}
