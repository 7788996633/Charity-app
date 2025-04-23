part of 'show_user_rate_cubit.dart';

@immutable
sealed class ShowUserRateState {}

final class ShowUserRateInitial extends ShowUserRateState {}

final class ShowUserRateSuccess extends ShowUserRateState {
  final List<RateModel> rates;

  ShowUserRateSuccess({required this.rates});
}

final class ShowUserRateLoading extends ShowUserRateState {}

final class ShowUserRateFail extends ShowUserRateState {
  final String errmsg;

  ShowUserRateFail({required this.errmsg});
}
