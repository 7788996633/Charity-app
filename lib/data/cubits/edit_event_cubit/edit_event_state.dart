part of 'edit_event_cubit.dart';

@immutable
sealed class EditEventState {}

final class EditEventInitial extends EditEventState {}

final class EditEventSuccess extends EditEventState {
  final String successmsg;

  EditEventSuccess({required this.successmsg});
}

final class EditEventFail extends EditEventState {
  final String errmsg;

  EditEventFail({required this.errmsg});
}

final class EditEventLoading extends EditEventState {

}
