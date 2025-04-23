part of 'delete_help_request_cubit.dart';

@immutable
sealed class DeleteHelpRequestState {}

final class DeleteHelpRequestInitial extends DeleteHelpRequestState {}

final class DeleteHelpRequestSuccess extends DeleteHelpRequestState {
  final String successmsg;

  DeleteHelpRequestSuccess({required this.successmsg});
}

final class DeleteHelpRequestLoading extends DeleteHelpRequestState {}

final class DeleteHelpRequestFail extends DeleteHelpRequestState {
  final String errmsg;

  DeleteHelpRequestFail({required this.errmsg});
}
