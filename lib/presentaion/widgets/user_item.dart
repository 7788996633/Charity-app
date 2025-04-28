import 'package:baader/data/cubits/change_user_role_cubit/change_user_role_cubit.dart';
import 'package:baader/data/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cubits/delete_user_account_cubit/delete_user_account_cubit.dart';
import '../../data/cubits/show_users_cubit/show_users_cubit.dart';
import '../screens/profile_screen.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: const Color.fromARGB(255, 31, 25, 107),
      child: BlocListener<DeleteUserAccountCubit, DeleteUserAccountState>(
        listener: (context, state) {
          if (state is DeleteUserAccountSuccess) {
            BlocProvider.of<ShowUsersCubit>(context).showUsers();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: const Color.fromARGB(255, 146, 100, 239),
                content: Text(
                  "${userModel.firstName} has been deleted successfully",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else if (state is DeleteUserAccountFail) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: const Color.fromARGB(255, 146, 100, 239),
                content: Text(
                  state.errmsg,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
        },
        child: BlocListener<ChangeUserRoleCubit, ChangeUserRoleState>(
          listener: (context, state) {
            if (state is ChangeUserRoleSuccess) {
              BlocProvider.of<ShowUsersCubit>(context)
                  .showUsers(); // إعادة تحميل البيانات
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 146, 100, 239),
                  content: Text(
                    "${userModel.firstName}'s role has been changed successfully",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            } else if (state is ChangeUserRoleFail) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 146, 100, 239),
                  content: Text(
                    state.errmsg,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }
          },
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(userModel: userModel),
                ),
              );
            },
            title: Text(
              '${userModel.firstName} ${userModel.lastName}',
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                userModel.image,
              ),
            ),
            subtitle: Text(
              userModel.role,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: PopupMenuButton<String>(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onSelected: (value) {
                switch (value) {
                  case 'delete':
                    context
                        .read<DeleteUserAccountCubit>()
                        .deleteUserAccount(userModel.id);
                    break;
                  case 'volunteer':
                    context
                        .read<ChangeUserRoleCubit>()
                        .changeRole(userModel.id, 'volunteer');
                    break;
                  case 'user':
                    context
                        .read<ChangeUserRoleCubit>()
                        .changeRole(userModel.id, 'user');
                    break;
                  case 'admin':
                    context
                        .read<ChangeUserRoleCubit>()
                        .changeRole(userModel.id, 'admin');
                    break;
                  case 'super_admin':
                    context
                        .read<ChangeUserRoleCubit>()
                        .changeRole(userModel.id, 'super_admin');
                    break;
                }
              },
              itemBuilder: (context) {
                if (userModel.role == 'user') {
                  return [
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text("Delete"),
                    ),
                    const PopupMenuItem(
                      value: 'volunteer',
                      child: Text("Volunteer"),
                    ),
                  ];
                } else if (userModel.role == 'volunteer') {
                  return [
                    const PopupMenuItem(
                      value: 'user',
                      child: Text("User"),
                    ),
                    const PopupMenuItem(
                      value: 'admin',
                      child: Text("Admin"),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text("Delete"),
                    ),
                  ];
                } else if (userModel.role == 'admin') {
                  return [
                    const PopupMenuItem(
                      value: 'user',
                      child: Text("User"),
                    ),
                    const PopupMenuItem(
                      value: 'volunteer',
                      child: Text("Volunteer"),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text("Delete"),
                    ),
                  ];
                } else {
                  return [
                    const PopupMenuItem(
                      value: 'user',
                      child: Text("User"),
                    ),
                    const PopupMenuItem(
                      value: 'volunteer',
                      child: Text("Volunteer"),
                    ),
                    const PopupMenuItem(
                      value: 'admin',
                      child: Text("Admin"),
                    ),
                  ];
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
