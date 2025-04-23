import 'package:baader/data/services/volunteer_request_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'confirm_volunteer_request_state.dart';

class ConfirmVolunteerRequestCubit extends Cubit<ConfirmVolunteerRequestState> {
  ConfirmVolunteerRequestCubit() : super(ConfirmVolunteerRequestInitial());
  void confirmVolReq(int id) {
    emit(
      ConfirmVolunteerRequestLoading(),
    );
    try {
      VolunteerRequestServices().confirmVolunteerRequest(id).then(
            (value) => emit(
              ConfirmVolunteerRequestSuccess(
                successmsg: value,
              ),
            ),
          );
    } on Exception catch (e) {
      emit(
        ConfirmVolunteerRequestFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
