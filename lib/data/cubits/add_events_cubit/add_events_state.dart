part of 'add_events_cubit.dart';

@immutable
sealed class AddEventsState {}

final class AddEventsInitial extends AddEventsState {}

final class AddEventsSuccess extends AddEventsState {
  final String successmsg;

  AddEventsSuccess({required this.successmsg});
}

final class AddEventsLoading extends AddEventsState {}

final class AddEventsFail extends AddEventsState {
  final String errmsg;

  AddEventsFail({required this.errmsg});
}
