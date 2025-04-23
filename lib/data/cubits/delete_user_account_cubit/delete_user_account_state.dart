part of 'delete_user_account_cubit.dart';

@immutable
sealed class DeleteUserAccountState {}

final class DeleteUserAccountInitial extends DeleteUserAccountState {}

final class DeleteUserAccountSuccess extends DeleteUserAccountState {}

final class DeleteUserAccountLoading extends DeleteUserAccountState {}

final class DeleteUserAccountFail extends DeleteUserAccountState {
  final String errmsg;

  DeleteUserAccountFail({required this.errmsg});
}
