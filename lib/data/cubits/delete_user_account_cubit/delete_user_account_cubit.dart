import 'package:baader/data/services/user_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_user_account_state.dart';

class DeleteUserAccountCubit extends Cubit<DeleteUserAccountState> {
  DeleteUserAccountCubit() : super(DeleteUserAccountInitial());

  void deleteUserAccount(int userId) {
    emit(
      DeleteUserAccountLoading(),
    );
    try {
      UserServices().deleteUserAccount(userId);
      emit(
        DeleteUserAccountSuccess(),
      );
    } on Exception catch (e) {
      emit(
        DeleteUserAccountFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
