// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:baader/data/helper/api.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class RegisterService {
  Future<String> register(
    String firstName,
    String lastName,
    String email,
    String passWord,
    String phone,
    File image,
  ) async {
    var headers = {'Accept': 'application/json'};
    var request =
        http.MultipartRequest('POST', Uri.parse('${Api().myUrl}api/register'));
    request.fields.addAll({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': passWord,
      'phone': phone
    });
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    var data = json.decode(response.body);

    if (data['message'] == 'success') {
      print(
        data,
      );
      return data['token'];
    } else {
      print(
        data,
      );
      return 'fail';
    }
  }
}
