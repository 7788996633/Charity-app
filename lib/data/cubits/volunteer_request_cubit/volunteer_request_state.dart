part of 'volunteer_request_cubit.dart';

@immutable
sealed class VolunteerRequestState {}

final class VolunteerRequestInitial extends VolunteerRequestState {}

final class VolunteerRequestSuccess extends VolunteerRequestState {
  final String successmsg;

  VolunteerRequestSuccess({required this.successmsg});
}

final class VolunteerRequestLoading extends VolunteerRequestState {}

final class VolunteerRequestFail extends VolunteerRequestState {
  final String errmsg;

  VolunteerRequestFail({required this.errmsg});
}
