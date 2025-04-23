// ignore_for_file: avoid_print

import '../../constants.dart';
import '../helper/api.dart';

class LogOutService {
  Future logOut() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var data = await Api().postt('api/logout', headers, null);
    print(data);
  }
}
