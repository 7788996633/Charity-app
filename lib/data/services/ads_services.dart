// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:baader/constants.dart';
import 'package:baader/data/helper/api.dart';

class AdsServices {
  Future<String> addAds(String title, File selectedImage) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${Api().myUrl}api/add_Ads'));

    request.fields.addAll({
      'title': title,
      'description': 'desc',
    });
    request.files
        .add(await http.MultipartFile.fromPath('image', selectedImage.path));
    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    return jsonResponse['message'];
  }

  Future<List> showAds() async {
    var data = await Api().gett(
      'api/Show_ads',
    );
    if (data['message'] == 'success') {
      print(data);
      return data['Ads'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }
}
