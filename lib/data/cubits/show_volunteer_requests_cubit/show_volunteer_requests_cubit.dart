import 'package:baader/data/repository/volunteer_requests_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/volunteer_request_model.dart';

part 'show_volunteer_requests_state.dart';

class ShowVolunteerRequestsCubit extends Cubit<ShowVolunteerRequestsState> {
  ShowVolunteerRequestsCubit() : super(ShowVolunteerRequestsInitial());

  void showVols() {
    emit(
      ShowVolunteerRequestsLoading(),
    );

    try {
      VolunteerRequestsRepository().showVolunteerRequests().then(
            (value) => emit(
              ShowVolunteerRequestsSuccess(vols: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        ShowVolunteerRequestsFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
