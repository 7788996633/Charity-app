import 'package:baader/data/models/donation_numbersmodel.dart';
import 'package:baader/data/services/donation_numbers_services.dart';

class DonationNumbersRepository {
  Future<List<DonationNumberModel>> showDonationNumbers() async {
    var donationNumberList =
        await DonationNumbersServices().showDonationNumbers();
    return donationNumberList
        .map((e) => DonationNumberModel.fromJson(e))
        .toList();
  }
}
