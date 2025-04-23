part of 'delete_ads_cubit.dart';

@immutable
sealed class DeleteAdsState {}

final class DeleteAdsInitial extends DeleteAdsState {}

final class DeleteAdsLoading extends DeleteAdsState {}

final class DeleteAdsSuccess extends DeleteAdsState {
  final String successmsg;

  DeleteAdsSuccess({required this.successmsg});
}

final class DeleteAdsFail extends DeleteAdsState {
  final String errmsg;

  DeleteAdsFail({required this.errmsg});
}
