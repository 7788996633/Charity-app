part of 'donation_numbers_cubit.dart';

@immutable
sealed class DonationNumbersState {}

final class DonationNumbersInitial extends DonationNumbersState {}

final class DonationNumbersSuccess extends DonationNumbersState {
  final List<DonationNumberModel> donationNumbersList;

  DonationNumbersSuccess({required this.donationNumbersList});
}

final class DonationNumbersLoading extends DonationNumbersState {}

final class DonationNumbersFail extends DonationNumbersState {
  final String errmsg;

  DonationNumbersFail({required this.errmsg});
}
