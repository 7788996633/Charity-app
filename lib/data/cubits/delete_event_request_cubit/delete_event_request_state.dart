part of 'delete_event_request_cubit.dart';

@immutable
sealed class DeleteEventRequestState {}

final class DeleteEventRequestInitial extends DeleteEventRequestState {}

final class DeleteEventRequestsSuccess extends DeleteEventRequestState {
  final String successmsg;

  DeleteEventRequestsSuccess({required this.successmsg});
}

final class DeleteEventRequestsLoading extends DeleteEventRequestState {}

final class DeleteEventRequestsFail extends DeleteEventRequestState {
  final String errmsg;

  DeleteEventRequestsFail({required this.errmsg});
}
