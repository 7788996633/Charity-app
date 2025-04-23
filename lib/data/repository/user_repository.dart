import 'package:baader/data/services/user_services.dart';

import '../models/usermodel.dart';

class UserRepository {
  Future<UserModel> showUserInfo() async {
    var userInfo = await UserServices().showUserInfo();
    List<UserModel> usersModel = [];
    usersModel.add(UserModel.fromJson(userInfo));
    return usersModel[0];
  }

  // Future<String> showUserRole() async {
  //   var userInfo = await UserServices().showUserInfo();
  //   List<UserModel> usersModel = [];
  //   usersModel.add(UserModel.fromJson(userInfo));
  //   return usersModel[0].role;
  // }

  Future<List<UserModel>> showUsers() async {
    var users = await UserServices().showUsers();
    return users.map((e) => UserModel.fromJson(e)).toList();
  }

  Future<List<UserModel>> showOurTeam() async {
    var team = await UserServices().showOurTeam();
    return team.map((e) => UserModel.fromJson(e)).toList();
  }
}
