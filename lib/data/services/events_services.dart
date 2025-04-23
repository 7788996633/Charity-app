// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:baader/constants.dart';
import 'package:baader/data/models/eventmodel.dart';

import '../helper/api.dart';
import 'package:http/http.dart' as http;

class EventsServices {
  Future<List> showEvents() async {
    var data = await Api().gett(
      'api/ShowEvent',
    );
    if (data['message'] == 'success') {
      print(data);
      return data['events'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }

  Future<void> reactToEvents(String eventId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var data = await Api().postt('api/React_to_events/$eventId', headers, null);
    print(data);
  }

  Future<String> addEvent(
      String name,
      // String type,
      String desc,
      String startdate,
      String enddate,
      String location,
      File selectedImage) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${Api().myUrl}api/addEvent'));
    request.fields.addAll({
      'name': name,
      'type': "aa",
      'description': desc,
      'target_category': "aa",
      'start_date': startdate,
      'end_date': enddate,
      'location': location
    });
    request.files
        .add(await http.MultipartFile.fromPath('image', selectedImage.path));
    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    return jsonResponse['message'];
  }

  Future<String> updateEvent(
      int eventId,
      String name,
      // String type,
      String desc,
      // String startdate,
      // String enddate,
      String location,
      File? selectedImage) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Api().myUrl}api/updateEvent/$eventId'));
    request.fields.addAll({
      'name': name,
      // 'type': type,
      'description': desc,
      // 'target_category': "",
      // 'start_date': startdate,
      // 'end_date': enddate,
      'location': location
    });if(selectedImage!=null) {
      request.files
        .add(await http.MultipartFile.fromPath('image', selectedImage.path));
    }
    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    return jsonResponse['message'];
  }

  Future<String> deleteEvent(int eventId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Api().myUrl}api/deleteEvent/$eventId'),
    );

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    return jsonResponse['message'];
  }

  Future<String> subscribeToEventAsABen(int eventId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var data = await Api()
        .postt("api/Subscribe_to_event_bene/$eventId", headers, null);

    print(data);
    return (data['message']);
  }

  Future<String> subscribeToEventAsAVolunteer(int eventId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var data = await Api()
        .postt("api/Subscribe_to_events_vol/$eventId", headers, null);

    print(data);
    return (data['message']);
  }

  Future<List> showBenifitRequest(int eventId) async {
    var data = await Api().gett(
      'api/show_benEvent_requests/$eventId',
    );
    if (data['message'] == 'success') {
      print("===================================");
      print(data);
      return data['Volunteer_requests'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }

  Future<List> showVolunteersRequest(int eventId) async {
    var data = await Api().gett(
      'api/show_volEvent_requests/$eventId',
    );
    if (data['message'] == 'success') {
      print("===================================");
      print(data);
      return data['Volunteer_requests'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }

  Future<String> confirmBenReq(int requestId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var data = await Api()
        .postt('api/confirm_benEvent_requests/$requestId', headers, null);
    print(data);
    return data['message'];
  }

  Future<String> confirmVolReq(int requestId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var data = await Api()
        .postt('api/confirm_volEvent_requests/$requestId', headers, null);
    print(data);
    return data['message'];
  }

  Future<String> deleteVolReq(int requestId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var data = await Api()
        .postt('api/delete_volEvent_requests/$requestId', headers, null);
    print(data);
    return data['message'];
  }

  Future<String> deleteBenReq(int requestId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var data = await Api()
        .postt('api/delete_benEvent_requests/$requestId', headers, null);
    print(data);
    return data['message'];
  }

  Future<EventModel> getEventById(int eventId) async {
    var data = await Api().gett(
      'api/Show_Event_by_id/$eventId',
    );

    print(data);

    final userJson = data['event'];
    final event = EventModel.fromJson(userJson);

    return event;
  }

  Future<List> showHotEvents() async {
    var data = await Api().gett(
      'api/hotList',
    );
    if (data['message'] == 'success') {
      print(data);
      return data['HotList']['events'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }
}
