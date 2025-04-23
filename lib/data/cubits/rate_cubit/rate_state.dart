part of 'rate_cubit.dart';

@immutable
sealed class RateState {}

final class RateInitial extends RateState {}

final class RateSuccess extends RateState {
  final String successmsg;

  RateSuccess({required this.successmsg});
}

final class RateLoading extends RateState {}

final class RateFail extends RateState {
  final String errmsg;

  RateFail({required this.errmsg});
}
