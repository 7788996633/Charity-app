// ignore_for_file: avoid_print

import 'dart:convert';

import '../../constants.dart';
import '../helper/api.dart';
import 'package:http/http.dart' as http;

class HelpRequestServices {
  Future<List> showHelpRequests() async {
    var data = await Api().gett(
      'api/show_help_requests',
    );
    if (data['message'] == 'success') {
      print(data);
      return data['Help_requests'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }

  Future<String> helpRequest(
    String desc,
    String city,
    String street,
    String neigh,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var body = ({
      'description': desc,
      'city': city,
      'street': street,
      'neighborhood': neigh
    });
    var data = await Api().postt('api/help_request', headers, body);
    print(data);
    return data['message'];
  }

  Future<String> confirmHelpRequest(int helpReqId) async {
    var data = await Api().gett(
      'api/confirm_help_requests/$helpReqId',
    );

    return data['message'];
  }

  Future<String> deleteHelpRequest(int helpReqId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var request = http.Request('DELETE',
        Uri.parse('${Api().myUrl} api/delete_help_requests/$helpReqId'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    return jsonResponse['message'];
  }
}
