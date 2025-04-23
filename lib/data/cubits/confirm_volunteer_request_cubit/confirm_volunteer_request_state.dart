part of 'confirm_volunteer_request_cubit.dart';

@immutable
sealed class ConfirmVolunteerRequestState {}

final class ConfirmVolunteerRequestInitial
    extends ConfirmVolunteerRequestState {}

final class ConfirmVolunteerRequestSuccess
    extends ConfirmVolunteerRequestState {
  final String successmsg;

  ConfirmVolunteerRequestSuccess({required this.successmsg});
}

final class ConfirmVolunteerRequestLoading
    extends ConfirmVolunteerRequestState {}

final class ConfirmVolunteerRequestFail extends ConfirmVolunteerRequestState {
  final String errmsg;

  ConfirmVolunteerRequestFail({required this.errmsg});
}
