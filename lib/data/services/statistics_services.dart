// ignore_for_file: avoid_print

import 'package:baader/constants.dart';
import 'package:baader/data/helper/api.dart';

class StatisticsServices {
  Future<List> showStatistics() async {
    var data = await Api().gett(
      'api/show_statics',
    );
    if (data['message'] == 'success') {
      print(data);
      return data['Statics'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }

  Future<String> addSt(int eventId, String desc) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var body = ({'description': desc});

    var data = await Api().postt('api/Add_statics/$eventId', headers, body);
    print(data);

    return data['message'];
  }

  Future<String> deleteSt(int eventId) async {
    var headers = {'Authorization': 'Bearer $myToken'};

    var data = await Api().postt('api/delete_statics/$eventId', headers, null);
    print(data);

    return data['message'];
  }
}
