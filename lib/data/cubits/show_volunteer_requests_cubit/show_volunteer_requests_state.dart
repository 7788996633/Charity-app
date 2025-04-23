part of 'show_volunteer_requests_cubit.dart';

@immutable
sealed class ShowVolunteerRequestsState {}

final class ShowVolunteerRequestsInitial extends ShowVolunteerRequestsState {}

final class ShowVolunteerRequestsSuccess extends ShowVolunteerRequestsState {
  final List<VolunteerRequestModel> vols;

  ShowVolunteerRequestsSuccess({required this.vols});
}

final class ShowVolunteerRequestsLoading extends ShowVolunteerRequestsState {}

final class ShowVolunteerRequestsFail extends ShowVolunteerRequestsState {
  final String errmsg;

  ShowVolunteerRequestsFail({required this.errmsg});
}
