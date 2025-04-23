part of 'add_donation_number_cubit.dart';

@immutable
sealed class AddDonationNumberState {}

final class AddDonationNumberInitial extends AddDonationNumberState {}

final class AddDonationNumberSuccess extends AddDonationNumberState {
  final String successmsg;

  AddDonationNumberSuccess({required this.successmsg});
}

final class AddDonationNumberLoading extends AddDonationNumberState {}

final class AddDonationNumberFail extends AddDonationNumberState {
  final String errnsg;

  AddDonationNumberFail({required this.errnsg});
}
