import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/volunteer_request_services.dart';

part 'delete_volunteer_request_state.dart';

class DeleteVolunteerRequestCubit extends Cubit<DeleteVolunteerRequestState> {
  DeleteVolunteerRequestCubit() : super(DeleteVolunteerRequestInitial());
  void deleteVolReq(int id) {
    emit(
      DeleteVolunteerRequestLoading(),
    );
    try {
      VolunteerRequestServices().deleteVolunteerRequest(id).then(
            (value) => emit(
              DeleteVolunteerRequestSuccess(
                successmsg: value,
              ),
            ),
          );
    } on Exception catch (e) {
      emit(
        DeleteVolunteerRequestFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
