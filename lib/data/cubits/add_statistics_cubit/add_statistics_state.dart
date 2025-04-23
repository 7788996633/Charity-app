part of 'add_statistics_cubit.dart';

@immutable
sealed class AddStatisticsState {}

final class AddStatisticsInitial extends AddStatisticsState {}

final class AddStatisticsSuccess extends AddStatisticsState {
  final String successmsg;

  AddStatisticsSuccess({required this.successmsg});
}

final class AddStatisticsLoading extends AddStatisticsState {}

final class AddStatisticsFail extends AddStatisticsState {
  final String errmsg;

  AddStatisticsFail({required this.errmsg});
}
