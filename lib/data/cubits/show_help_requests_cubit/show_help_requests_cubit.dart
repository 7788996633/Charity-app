import 'package:baader/data/repository/help_request_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/help_request_model.dart';

part 'show_help_requests_state.dart';

class ShowHelpRequestsCubit extends Cubit<ShowHelpRequestsState> {
  ShowHelpRequestsCubit() : super(ShowHelpRequestsInitial());
  void showHelpRequests() {
    emit(
      ShowHelpRequestsLodaing(),
    );
    try {
      HelpRequestRepository().showHelpRequests().then(
            (value) => emit(
              ShowHelpRequestsSuccess(helpreq: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        ShowHelpRequestsFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
