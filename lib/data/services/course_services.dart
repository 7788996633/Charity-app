// ignore_for_file: avoid_print

import 'package:baader/constants.dart';

import '../helper/api.dart';
import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;

class CourseServices {
  Future<List> showCourses() async {
    var data = await Api().gett(
      'api/show_courses',
    );
    if (data['message'] == 'success') {
      print(data);
      return data['courses'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }

  Future<List> showHotCourses() async {
    var data = await Api().gett(
      'api/hotList',
    );
    if (data['message'] == 'success') {
      print(data);
      return data['HotList']['courses'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }

  Future<String> addCourse(
    String name,
    String url,
    String desc,
    String discount,
    File selectedImage,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Api().myUrl}api/add_course'));

    request.fields.addAll({
      'name': name,
      'url': url,
      'discount': discount,
      'description': desc,
    });
    request.files
        .add(await http.MultipartFile.fromPath('image', selectedImage.path));
    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    return jsonResponse['message'];
  }

  Future<String> deleteCourse(int courseId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Api().myUrl}api/delete_course/$courseId'),
    );

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return jsonResponse['message'];
  }

  Future<String> updateCourse(
    int courseId,
    String name,
    String url,
    String desc,
    String discount,
    File? selectedImage,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Api().myUrl}api/updateEvent/$courseId'));
    request.fields.addAll({
      'name': name,
      'url': url,
      'discount': discount,
      'description': desc,
    });
    if (selectedImage != null) {
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
}
