// ignore_for_file: avoid_print

import 'package:baader/data/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/usermodel.dart';

part 'show_users_state.dart';

class ShowUsersCubit extends Cubit<ShowUsersState> {
  ShowUsersCubit() : super(ShowUsersInitial());

  void showUsers() {
    emit(
      ShowUsersLoading(),
    );
    try {
      UserRepository().showUsers().then(
            (value) => emit(
              ShowUsersSuccess(usersList: value),
            ),
          );
    } on Exception catch (e) {
      ShowUsersFail(
        errmsg: e.toString(),
      );
    }
  }
}
