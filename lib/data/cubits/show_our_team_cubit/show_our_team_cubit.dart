import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/usermodel.dart';
import '../../repository/user_repository.dart';

part 'show_our_team_state.dart';

class ShowOurTeamCubit extends Cubit<ShowOurTeamState> {
  ShowOurTeamCubit() : super(ShowOurTeamInitial());
  void showOurTeam() {
    emit(
      ShowOurTeamLoading(),
    );
    try {
      UserRepository().showOurTeam().then(
            (value) => emit(
              ShowOurTeamSuccess(teamList: value),
            ),
          );
    } on Exception catch (e) {
      ShowOurTeamFail(errmsg: e.toString());
    }
  }

}
