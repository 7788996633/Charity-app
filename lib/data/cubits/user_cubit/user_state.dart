part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserSuccess extends UserState {
  final UserModel userModel;

  UserSuccess({required this.userModel});
}

final class UserFail extends UserState {
  final String errmsg;

  UserFail({required this.errmsg});
}

final class UserLoading extends UserState {}
