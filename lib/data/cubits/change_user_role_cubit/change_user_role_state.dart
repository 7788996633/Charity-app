part of 'change_user_role_cubit.dart';

@immutable
sealed class ChangeUserRoleState {}

final class ChangeUserRoleInitial extends ChangeUserRoleState {}

final class ChangeUserRoleSuccess extends ChangeUserRoleState {}

final class ChangeUserRoleFail extends ChangeUserRoleState {
  final String errmsg;

  ChangeUserRoleFail({required this.errmsg});
}

final class ChangeUserRoleLoading extends ChangeUserRoleState {}
