// ignore_for_file: avoid_print

import 'package:baader/constants.dart';
import 'package:baader/data/models/usermodel.dart';

import '../helper/api.dart';

class UserServices {
  Future<Map> showUserInfo() async {
    var data = await Api().gett(
      'api/show_my_account',
    );
    try {
      print(data);
      return data['my_account'];
    } on Exception catch (e) {
      print(e);
      return {};
    }
  }

  Future<List> showUsers() async {
    var data = await Api().gett(
      'api/show_users',
    );
    try {
      print(data);
      return data['Users'];
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }

  Future<List> showOurTeam() async {
    var data = await Api().gett(
      'api/show_ourTeam',
    );
    if (data['message'] == 'success') {
      print(data);
      return data['Team'];
    } else {
      print(
        data['message'],
      );
      return [];
    }
  }

  Future changeUserRole(int userId, String userRole) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var body = ({'role': userRole});
    var data = await Api().postt('api/changeRole/$userId', headers, body);
    print(data);
  }

  Future<UserModel> getUserById(int userId) async {
    var data = await Api().gett('api/Show_User_by_id/$userId');

    print(data);

    final userJson = data['user'];
    final user = UserModel.fromJson(userJson);

    return user;
  }

  Future deleteUserAccount(int userId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var data =
        await Api().postt('api/delete_user_account/$userId', headers, null);
    print(data);
  }
}
