part of 'benifit_requests_cubit.dart';

@immutable
sealed class BenifitRequestsState {}

final class BenifitRequestsInitial extends BenifitRequestsState {}

final class BenifitRequestsSuccess extends BenifitRequestsState {
  final List<EventRequestModel> binList;

  BenifitRequestsSuccess({required this.binList});
}

final class BenifitRequestsLoading extends BenifitRequestsState {}

final class BenifitRequestsFail extends BenifitRequestsState {
  final String errmsg;

  BenifitRequestsFail({required this.errmsg});
}
