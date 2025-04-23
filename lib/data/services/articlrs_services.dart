// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:baader/constants.dart';
import 'package:baader/data/models/articlemodel.dart';

import '../helper/api.dart';
import 'package:http/http.dart' as http;

class ArticlesServices {
  Future<List> showArticles() async {
    var data = await Api().gett(
      'api/ShowArticle',
    );
    if (data['message'] == 'success') {
      print(data);
      return data['article'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }

  Future<ArticleModel> showArticleById(int articleId) async {
    var data = await Api().gett('api/Show_Article_by_id/$articleId');

    print(data);

    final articleJson = data['article'];
    final article = ArticleModel.fromJson(articleJson);

    return article;
  }

  Future<String> addArticle(
    String title,
    String desc,
    String category,
    File selectedImage,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Api().myUrl}api/addArticle'));

    request.fields.addAll({
      'title': title,
      'description': desc,
      'category': category,
    });
    request.files
        .add(await http.MultipartFile.fromPath('image', selectedImage.path));
    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    return jsonResponse['message'];
  }

  Future<String> deleteArticle(int articleId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Api().myUrl}api/deleteArticle/$articleId'),
    );

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    return jsonResponse['message'];
  }

  Future<List> showSavedArticles() async {
    var data = await Api().gett(
      'api/show_saved_article',
    );
    if (data['message'] == 'success') {
      print(data);
      return data['article'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }

  Future<List> showHotArticles() async {
    var data = await Api().gett(
      'api/hotList',
    );
    if (data['message'] == 'success') {
      print(data);
      return data['HotList']['articles'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }

  Future<String> saveArticle(int articleID) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var data = await Api().postt('api/save_article/$articleID', headers, null);
    print(data);
    return data['message'];
  }

  Future<String> unSaveArticle(int articleID) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var data =
        await Api().postt('api/cancelSave_article/$articleID', headers, null);
    print(data);
    return data['message'];
  }

  Future<String> updateArticle(
    int articleId,
    String title,
    String desc,
    String category,
    File? selectedImage,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Api().myUrl}api/updateEvent/$articleId'));
    request.fields.addAll({
      'title': title,
      'description': desc,
      'category': category,
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
