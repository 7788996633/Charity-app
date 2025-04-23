// ignore_for_file: avoid_print

import 'package:baader/constants.dart';

import '../helper/api.dart';

class VolunteerRequestServices {
  Future<List> showVolunteerRequests() async {
    var data = await Api().gett(
      'api/show_volunteer_requests',
    );
    if (data['message'] == 'success') {
      print(data);
      return data['Volunteer_requests'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }

  Future<List> showAcceptedVolunteerRequests() async {
    var data = await Api().gett(
      'api/show_accepted_volunteer_requests',
    );
    if (data['message'] == 'success') {
      print(data);
      return data['Volunteer_requests'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }

  Future<String> confirmVolunteerRequest(int id) async {
    var data = await Api().gett('api/confirm_volunteer_requests/$id');
    print(data);
    return data['message'];
  }

  Future<String> deleteVolunteerRequest(int id) async {
    var data = await Api().gett(
      'api/delete_volunteer_requests/$id',
    );
    print(data);
    return data['message'];
  }

  Future<String> volRequest(String stud, String skills, String avTime) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var body = ({
      'studding': stud,
      'skills': skills,
      'availableTime': avTime,
    });
    var data = await Api().postt('api/volunteer_request', headers, body);
    print(data);
    return data['message'];
  }
}
