part of 'confirm_benifit_requests_cubit.dart';

@immutable
sealed class ConfirmEventRequestsState {}

final class ConfirmEventRequestsInitial extends ConfirmEventRequestsState {}

final class ConfirmEventRequestsSuccess extends ConfirmEventRequestsState {
  final String successmsg;

  ConfirmEventRequestsSuccess({required this.successmsg});
}

final class ConfirmEventRequestsLoading extends ConfirmEventRequestsState {}

final class ConfirmEventRequestsFail extends ConfirmEventRequestsState {
  final String errmsg;

  ConfirmEventRequestsFail({required this.errmsg});
}
