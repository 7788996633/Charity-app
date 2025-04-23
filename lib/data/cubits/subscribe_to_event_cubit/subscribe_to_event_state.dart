part of 'subscribe_to_event_cubit.dart';

@immutable
sealed class SubscribeToEventState {}

final class SubscribeToEventInitial extends SubscribeToEventState {}

final class SubscribeToEventSuccess extends SubscribeToEventState {
  final String sucssessmsg;

  SubscribeToEventSuccess({required this.sucssessmsg});
}

final class SubscribeToEventLoading extends SubscribeToEventState {}

final class SubscribeToEventFail extends SubscribeToEventState {
  final String errmsg;

  SubscribeToEventFail({required this.errmsg});
}
