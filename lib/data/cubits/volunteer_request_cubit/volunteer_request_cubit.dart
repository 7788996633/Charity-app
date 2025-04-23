import 'package:baader/data/services/volunteer_request_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'volunteer_request_state.dart';

class VolunteerRequestCubit extends Cubit<VolunteerRequestState> {
  VolunteerRequestCubit() : super(VolunteerRequestInitial());

  void volReq(String stud, String skills, String avTime) {
    emit(
      VolunteerRequestLoading(),
    );
    try {
      VolunteerRequestServices().volRequest(stud, skills, avTime).then(
            (value) => emit(
              VolunteerRequestSuccess(successmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        VolunteerRequestFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
