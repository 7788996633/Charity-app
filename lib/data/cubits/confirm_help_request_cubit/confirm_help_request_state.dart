part of 'confirm_help_request_cubit.dart';

@immutable
sealed class ConfirmHelpRequestState {}

final class ConfirmHelpRequestInitial extends ConfirmHelpRequestState {}

final class ConfirmHelpRequestSuccess extends ConfirmHelpRequestState {
  final String successmsg;

  ConfirmHelpRequestSuccess({required this.successmsg});
}

final class ConfirmHelpRequestLoading extends ConfirmHelpRequestState {}

final class ConfirmHelpRequestFail extends ConfirmHelpRequestState {
  final String errmsg;

  ConfirmHelpRequestFail({required this.errmsg});
}
