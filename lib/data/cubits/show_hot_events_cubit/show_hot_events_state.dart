part of 'show_hot_events_cubit.dart';


@immutable
sealed class ShowHotEventsState {}

final class ShowHotEventsInitial extends ShowHotEventsState {}

final class ShowHotEventsuccess extends ShowHotEventsState {
  final List<EventModel> ev;

  ShowHotEventsuccess({required this.ev});
}

final class ShowHotAEventsLoading extends ShowHotEventsState {}

final class ShowHotAEventsFail extends ShowHotEventsState {
  final String errmsg;

  ShowHotAEventsFail({required this.errmsg});
}
