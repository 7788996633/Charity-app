// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:baader/constants.dart';
import 'package:baader/data/helper/api.dart';
import 'package:http/http.dart' as http;

class SuggestionsServices {
  Future<String> addSugg(String sugg) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var body = ({'description': sugg});

    var data = await Api().postt('api/write_suggestion', headers, body);
    print(data);
    return data['message'];
  }

  Future<String> confirmSugg(int suggId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var data =
        await Api().postt('api/confirm_suggestions/$suggId', headers, null);
    print(data);
    return data['message'];
  }

  Future<String> deleteSugg(int suggId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var request = http.Request(
        'DELETE', Uri.parse('${Api().myUrl}api/delete_suggestions/$suggId'));

    request.headers.addAll(headers);
    var data = jsonDecode(request.body);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    print(data);
    return data['message'];
  }

  Future<List> showSuggestions() async {
    var data = await Api().gett('api/show_suggestions');
    if (data['message'] == 'success') {
      print(data);
      return data['Suggestions'];
    } else {
      return [];
    }
  }

  Future<List> showAcceptedSuggestions() async {
    var data = await Api().gett('api/show_accepted_suggestions');
    if (data['message'] == 'success') {
      print(data);
      return data['Accepted_suggestions'];
    } else {
      return [];
    }
  }
}
