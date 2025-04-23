// ignore_for_file: avoid_print

import 'package:baader/constants.dart';

import '../helper/api.dart';

class DonationNumbersServices {
  Future<List> showDonationNumbers() async {
    var data = await Api().gett(
      'api/show_donation_numbers',
    );
    if (data['message'] == 'success') {
      print(data);
      return data['donation_number'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }

  Future<String> addDonationNumber(String phone) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var body = ({
      'phone': phone,
    });
    var data = await Api().postt('api/add_donation_number', headers, body);
    print(data);
    return data['message'];
  }
}
