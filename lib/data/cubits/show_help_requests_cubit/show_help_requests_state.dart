part of 'show_help_requests_cubit.dart';

@immutable
sealed class ShowHelpRequestsState {}

final class ShowHelpRequestsInitial extends ShowHelpRequestsState {}

final class ShowHelpRequestsSuccess extends ShowHelpRequestsState {
  final List<HelpRequestModel> helpreq;

  ShowHelpRequestsSuccess({required this.helpreq});
}

final class ShowHelpRequestsLodaing extends ShowHelpRequestsState {}

final class ShowHelpRequestsFail extends ShowHelpRequestsState {
  final String errmsg;

  ShowHelpRequestsFail({required this.errmsg});
}
