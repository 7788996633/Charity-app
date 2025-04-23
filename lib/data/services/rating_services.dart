// ignore_for_file: avoid_print

import 'package:baader/constants.dart';

import '../helper/api.dart';

class RatingServices {
  Future<String> rate(int userId, String rate, String comment) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var body = ({'comment': comment, 'rate': rate});
    var data = await Api().postt('api/rate_member_team/$userId', headers, body);
    print(data);
    return data['message'];
  }
   Future<List> showRate(int userId) async {
    var data = await Api().gett(
      'api/show_User_rate/$userId',
    );

    if (data['message'] == 'success') {
      print(data);
      return data['Comments'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }
}
