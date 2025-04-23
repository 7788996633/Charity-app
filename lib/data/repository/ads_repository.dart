import 'package:baader/data/models/ads_model.dart';
import 'package:baader/data/services/ads_services.dart';

class AdsRepository {
  Future<List<AdsModel>> showAds() async {
    var adsList = await AdsServices().showAds();
    return adsList
        .map(
          (e) => AdsModel.fromJson(e),
        )
        .toList();
  }
}
