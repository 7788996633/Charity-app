part of 'show_stat_cubit.dart';

@immutable
sealed class ShowStatState {}

final class ShowStatInitial extends ShowStatState {}

final class ShowStatSuccess extends ShowStatState {
  final List<StatistcsModel> st;

  ShowStatSuccess({required this.st});
}

final class ShowStatLoading extends ShowStatState {}

final class ShowStatFail extends ShowStatState {
  final String errmsg;

  ShowStatFail({required this.errmsg});
}
