import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/donation_numbersmodel.dart';
import '../../repository/donation_numbers.dart';

part 'donation_numbers_state.dart';

class DonationNumbersCubit extends Cubit<DonationNumbersState> {
  DonationNumbersCubit() : super(DonationNumbersInitial());

  void getDonationNumbers() {
    emit(DonationNumbersLoading());
    try {
      DonationNumbersRepository().showDonationNumbers().then(
        (value) {
          emit(
            DonationNumbersSuccess(donationNumbersList: value),
          );
        },
      );
    } on Exception catch (e) {
      emit(
        DonationNumbersFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
