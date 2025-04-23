// ignore_for_file: avoid_print

import '../helper/api.dart';

class LoginService {
  Future<String> login(String email, String password) async {
    var headers = {'Accept': 'application/json'};
    var body = ({'email': email, 'password': password});
    var data = await Api().postt('api/login', headers, body);
    if (data['message'] == 'success') {
      print(
        data,
      );
      return data['token'];
    } else {
      print(
        data['message'],
      );
      return 'fail';
    }
  }
}
