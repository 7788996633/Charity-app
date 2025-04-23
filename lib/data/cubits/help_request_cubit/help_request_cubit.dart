import 'package:baader/data/services/help_request_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'help_request_state.dart';

class HelpRequestCubit extends Cubit<HelpRequestState> {
  HelpRequestCubit() : super(HelpRequestInitial());

  void helpRequest(String desc, String city, String street, String neigh) {
    emit(
      HelpRequestLoading(),
    );
    try {
      HelpRequestServices().helpRequest(desc, city, street, neigh).then((value) =>     emit(
      HelpRequestSuccess(succesmsg: value),
    ),
);
    } on Exception catch (e) {
      emit(
        HelpRequestFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
