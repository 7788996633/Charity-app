import 'package:baader/data/cubits/user_role_cubit/user_role_cubit.dart';
import 'package:baader/data/models/usermodel.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:baader/presentaion/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/helper/api.dart';
import '../../data/cubits/user_cubit/user_cubit.dart';
import '../widgets/custom_list_tile.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key, required this.user});
  final UserModel user;
  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUserInfo(UserRoleCubit());
    super.initState();
  }

  late UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "My Profile",
      appBarActions: const Text(""),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserSuccess) {
            userModel = state.userModel;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      child: Image.network(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.45,
                        '${Api().myUrl}pictures/${userModel.image}',
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      "${userModel.firstName} ${userModel.lastName}",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    CustomContainar(
                      child: Column(
                        children: [
                          CustomListTile(
                            icon: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            title:
                                "${userModel.firstName} ${userModel.lastName}",
                            maxlines: 1,
                          ),
                          const Divider(color: Colors.white54),
                          CustomListTile(
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            title: "${userModel.phone}",
                            maxlines: 1,
                          ),
                          const Divider(color: Colors.white54),
                          CustomListTile(
                            icon: const Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            title: userModel.email,
                            maxlines: 1,
                          ),
                          const Divider(color: Colors.white54),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is UserFail) {
            return Column(
              children: [
                const Text(
                  "There is an error:",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  state.errmsg,
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            );
          } else {
            return const Center(
              child: CustomLoadingIndicator(),
            );
          }
        },
      ),
    );
  }
}
