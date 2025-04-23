part of 'delete_volunteer_request_cubit.dart';

@immutable
sealed class DeleteVolunteerRequestState {}

final class DeleteVolunteerRequestInitial extends DeleteVolunteerRequestState {}

final class DeleteVolunteerRequestLoading extends DeleteVolunteerRequestState {}

final class DeleteVolunteerRequestFail extends DeleteVolunteerRequestState {
  final String errmsg;

  DeleteVolunteerRequestFail({required this.errmsg});
}

final class DeleteVolunteerRequestSuccess extends DeleteVolunteerRequestState {
  final String successmsg;

  DeleteVolunteerRequestSuccess({required this.successmsg});
}
