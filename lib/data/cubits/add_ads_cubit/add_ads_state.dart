part of 'add_ads_cubit.dart';

@immutable
sealed class AddAdsState {}

final class AddAdsInitial extends AddAdsState {}

final class AddAdsSuccess extends AddAdsState {
  final String successmsg;

  AddAdsSuccess({required this.successmsg});
}

final class AddAdsLoading extends AddAdsState {}

final class AddAdsFail extends AddAdsState {
  final String errmsg;

  AddAdsFail({required this.errmsg});
}
