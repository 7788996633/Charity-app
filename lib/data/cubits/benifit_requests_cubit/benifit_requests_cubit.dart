import 'package:baader/data/repository/events_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/benifit_request_model.dart';

part 'benifit_requests_state.dart';

class BenifitRequestsCubit extends Cubit<BenifitRequestsState> {
  BenifitRequestsCubit() : super(BenifitRequestsInitial());

  void showBinList(int eventId) {
    emit(
      BenifitRequestsLoading(),
    );
    try {
      EventsRepository().showBenifitRequest(eventId).then(
            (value) => emit(
              BenifitRequestsSuccess(binList: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        BenifitRequestsFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
