import 'package:baader/data/models/ads_model.dart';
import 'package:baader/data/repository/ads_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_ads_state.dart';

class ShowAdsCubit extends Cubit<ShowAdsState> {
  ShowAdsCubit() : super(ShowAdsInitial());
  void showAds() {
    emit(
      ShowAdsLoading(),
    );
    try {
      AdsRepository().showAds().then(
            (value) => emit(
              ShowAdsSuccess(ads: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        ShowAdsFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
