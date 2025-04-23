part of 'help_request_cubit.dart';

@immutable
sealed class HelpRequestState {}

final class HelpRequestInitial extends HelpRequestState {}

final class HelpRequestSuccess extends HelpRequestState {
  final String succesmsg;

  HelpRequestSuccess({required this.succesmsg});
}

final class HelpRequestLoading extends HelpRequestState {}

final class HelpRequestFail extends HelpRequestState {
  final String errmsg;

  HelpRequestFail({required this.errmsg});
}
