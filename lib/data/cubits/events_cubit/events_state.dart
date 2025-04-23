part of 'events_cubit.dart';

@immutable
sealed class EventsState {}

final class EventsInitial extends EventsState {}
final class EventSuccess extends EventsState {
  final List<EventModel> ev;

  EventSuccess({required this.ev});
}

final class EventLoading extends EventsState {}

final class EventFail extends EventsState {
  final String errmsg;

  EventFail({required this.errmsg});
}
