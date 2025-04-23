import 'package:baader/data/models/rate_model.dart';
import 'package:baader/data/services/rating_services.dart';

class RateRepository {
  Future<List<RateModel>> showUserRate(int userId) async {
    var rateList = await RatingServices().showRate(userId);
    return rateList
        .map(
          (e) => RateModel.fromJson(e),
        )
        .toList();
  }
}
