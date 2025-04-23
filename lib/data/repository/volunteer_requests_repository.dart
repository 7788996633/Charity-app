import 'package:baader/data/models/volunteer_request_model.dart';
import 'package:baader/data/services/volunteer_request_services.dart';

class VolunteerRequestsRepository {
  Future<List<VolunteerRequestModel>> showVolunteerRequests() async {
    var volunteersReqList =
        await VolunteerRequestServices().showVolunteerRequests();
    return volunteersReqList
        .map((e) => VolunteerRequestModel.fromJson(e))
        .toList();
  }
}
