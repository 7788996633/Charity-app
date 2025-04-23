import 'package:baader/data/models/help_request_model.dart';
import 'package:baader/data/services/help_request_services.dart';

class HelpRequestRepository {
  Future<List<HelpRequestModel>> showHelpRequests() async {
    var helpRequestsList = await HelpRequestServices().showHelpRequests();
    return helpRequestsList
        .map(
          (e) => HelpRequestModel.fromJson(e),
        )
        .toList();
  }
}
