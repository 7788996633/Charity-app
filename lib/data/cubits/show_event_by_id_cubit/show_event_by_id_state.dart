part of 'show_event_by_id_cubit.dart';

@immutable
sealed class ShowEventByIdState {}

final class ShowEventByIdInitial extends ShowEventByIdState {}

final class ShowEventByIdSuccess extends ShowEventByIdState {
  final EventModel ev;

  ShowEventByIdSuccess({required this.ev});
}

final class ShowEventByIdLoading extends ShowEventByIdState {}

final class ShowEventByIdFail extends ShowEventByIdState {
  final String errmsg;

  ShowEventByIdFail({required this.errmsg});
}
