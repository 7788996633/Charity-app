import 'package:baader/data/services/ads_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_ads_state.dart';

class DeleteAdsCubit extends Cubit<DeleteAdsState> {
  DeleteAdsCubit() : super(DeleteAdsInitial());
  void deleteAds(int id) {
    emit(
      DeleteAdsLoading(),
    );
    try {
      AdsServices();
    } on Exception catch (e) {
      emit(
        DeleteAdsFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
