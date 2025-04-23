import 'package:baader/data/models/benifit_request_model.dart';
import 'package:baader/data/models/eventmodel.dart';
import 'package:baader/data/services/events_services.dart';

class EventsRepository {
  Future<List<EventModel>> showEvents() async {
    var eventsList = await EventsServices().showEvents();
    return eventsList
        .map(
          (e) => EventModel.fromJson(e),
        )
        .toList();
  }

  Future<List<EventModel>> showHotEvents() async {
    var eventsList = await EventsServices().showHotEvents();
    return eventsList
        .map(
          (e) => EventModel.fromJson(e),
        )
        .toList();
  }

  Future<List<EventRequestModel>> showBenifitRequest(int eventId) async {
    var benList = await EventsServices().showBenifitRequest(eventId);
    return benList
        .map(
          (e) => EventRequestModel.fromJson(e),
        )
        .toList();
  }

    Future<List<EventRequestModel>> showVolunteerRequest(int eventId) async {
    var benList = await EventsServices().showVolunteersRequest(eventId);
    return benList
        .map(
          (e) => EventRequestModel.fromJson(e),
        )
        .toList();
  }

}
