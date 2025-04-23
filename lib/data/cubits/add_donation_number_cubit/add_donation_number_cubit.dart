import 'package:baader/data/services/donation_numbers_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_donation_number_state.dart';

class AddDonationNumberCubit extends Cubit<AddDonationNumberState> {
  AddDonationNumberCubit() : super(AddDonationNumberInitial());
  void addDonationNumber(String phone) {
    emit(
      AddDonationNumberLoading(),
    );
    try {
      DonationNumbersServices().addDonationNumber(phone).then(
            (value) => emit(
              AddDonationNumberSuccess(successmsg: value),
            ),
          );
    } on Exception catch (e) {
      emit(
        AddDonationNumberFail(
          errnsg: e.toString(),
        ),
      );
    }
  }
}
