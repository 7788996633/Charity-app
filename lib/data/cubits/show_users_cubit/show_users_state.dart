part of 'show_users_cubit.dart';

@immutable
sealed class ShowUsersState {}

final class ShowUsersInitial extends ShowUsersState {}

final class ShowUsersSuccess extends ShowUsersState {
  final List<UserModel> usersList;

  ShowUsersSuccess({required this.usersList});
}

final class ShowUsersLoading extends ShowUsersState {}

final class ShowUsersFail extends ShowUsersState {
  final String errmsg;

  ShowUsersFail({required this.errmsg});
}
