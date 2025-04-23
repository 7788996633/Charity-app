part of 'show_ads_cubit.dart';

@immutable
sealed class ShowAdsState {}

final class ShowAdsInitial extends ShowAdsState {}

final class ShowAdsSuccess extends ShowAdsState {
  final List<AdsModel> ads;

  ShowAdsSuccess({required this.ads});
}

final class ShowAdsFail extends ShowAdsState {
  final String errmsg;

  ShowAdsFail({required this.errmsg});
}

final class ShowAdsLoading extends ShowAdsState {}
