import 'package:baader/data/models/statistics_model.dart';
import 'package:baader/data/services/statistics_services.dart';

class StatisticsRepository {
  Future<List<StatistcsModel>> showStatistics() async {
    var statList = await StatisticsServices().showStatistics();
    return statList
        .map(
          (e) => StatistcsModel.fromJson(e),
        )
        .toList();
  }
}
