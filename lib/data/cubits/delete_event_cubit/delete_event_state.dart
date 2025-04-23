part of 'delete_event_cubit.dart';

@immutable
sealed class DeleteEventState {}

final class DeleteEventInitial extends DeleteEventState {}

final class DeleteEventSuccess extends DeleteEventState {
  final String successmsg;

  DeleteEventSuccess({required this.successmsg});
}

final class DeleteEventFail extends DeleteEventState {
  final String errmsg;

  DeleteEventFail({required this.errmsg});
}

final class DeleteEventLoading extends DeleteEventState {}
