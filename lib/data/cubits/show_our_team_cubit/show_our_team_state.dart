part of 'show_our_team_cubit.dart';

@immutable
sealed class ShowOurTeamState {}

final class ShowOurTeamInitial extends ShowOurTeamState {}

final class ShowOurTeamSuccess extends ShowOurTeamState {
  final List<UserModel> teamList;

  ShowOurTeamSuccess({required this.teamList});
}

final class ShowOurTeamLoading extends ShowOurTeamState {}

final class ShowOurTeamFail extends ShowOurTeamState {
  final String errmsg;

  ShowOurTeamFail({required this.errmsg});
}
