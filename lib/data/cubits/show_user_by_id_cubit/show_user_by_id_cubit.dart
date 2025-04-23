import 'package:baader/data/models/usermodel.dart';
import 'package:baader/data/services/user_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_user_by_id_state.dart';

class ShowUserByIdCubit extends Cubit<ShowUserByIdState> {
  ShowUserByIdCubit() : super(ShowUserByIdInitial());

  void getUser(int userId) {
    emit(
      ShowUserByIdLoading(),
    );
    try {
      UserServices().getUserById(userId).then(
            (value) => emit(
              ShowUserByIdSuccess(user: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        ShowUserByIdFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
