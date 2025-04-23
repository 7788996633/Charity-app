part of 'user_role_cubit.dart';

@immutable
sealed class UserRoleState {}

final class UserRoleInitial extends UserRoleState {}

final class UserRoleSuperAdmin extends UserRoleState {}

final class UserRoleAdmin extends UserRoleState {}

final class UserRoleVolunteer extends UserRoleState {}

final class UserRoleNormal extends UserRoleState {}
