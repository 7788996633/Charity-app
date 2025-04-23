part of 'show_user_by_id_cubit.dart';

@immutable
sealed class ShowUserByIdState {}

final class ShowUserByIdInitial extends ShowUserByIdState {}

final class ShowUserByIdSuccess extends ShowUserByIdState {
  final UserModel user;

  ShowUserByIdSuccess({required this.user});
}

final class ShowUserByIdLoading extends ShowUserByIdState {}

final class ShowUserByIdFail extends ShowUserByIdState {
  final String errmsg;

  ShowUserByIdFail({required this.errmsg});
}
