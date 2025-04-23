import 'dart:io';

import 'package:baader/data/services/ads_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_ads_state.dart';

class AddAdsCubit extends Cubit<AddAdsState> {
  AddAdsCubit() : super(AddAdsInitial());
  void addAds(String title, File image) {
    emit(
      AddAdsLoading(),
    );
    try {
      AdsServices().addAds(title, image).then(
            (value) => emit(
              AddAdsSuccess(
                successmsg: value,
              ),
            ),
          );
    } on Exception catch (e) {
      emit(
        AddAdsFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
