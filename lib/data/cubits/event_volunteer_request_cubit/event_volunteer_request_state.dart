part of 'event_volunteer_request_cubit.dart';

@immutable
sealed class EventVolunteerRequestState {}

final class EventVolunteerRequestInitial extends EventVolunteerRequestState {}

final class EventVolunteerRequestSuccess extends EventVolunteerRequestState {
  final List<EventRequestModel> reqs;

  EventVolunteerRequestSuccess({required this.reqs});
}

final class EventVolunteerRequestLoading extends EventVolunteerRequestState {}

final class EventVolunteerRequestFail extends EventVolunteerRequestState {
  final String errmsg;

  EventVolunteerRequestFail({required this.errmsg});
}
