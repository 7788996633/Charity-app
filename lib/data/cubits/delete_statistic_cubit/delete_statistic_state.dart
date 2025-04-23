part of 'delete_statistic_cubit.dart';

@immutable
sealed class DeleteStatisticState {}

final class DeleteStatisticInitial extends DeleteStatisticState {}

final class DeleteStatisticSuccess extends DeleteStatisticState {
  final String successmsg;

  DeleteStatisticSuccess({required this.successmsg});
}

final class DeleteStatisticLoading extends DeleteStatisticState {}

final class DeleteStatisticFail extends DeleteStatisticState {
  final String errmsg;

  DeleteStatisticFail({required this.errmsg});
}
