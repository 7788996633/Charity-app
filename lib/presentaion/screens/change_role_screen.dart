import 'package:baader/data/cubits/show_users_cubit/show_users_cubit.dart';
import 'package:baader/data/models/usermodel.dart';
import 'package:baader/presentaion/widgets/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_scaffold.dart';

class ChangeRoleScreen extends StatefulWidget {
  const ChangeRoleScreen({super.key});

  @override
  State<ChangeRoleScreen> createState() => _ChangeRoleScreenState();
}

class _ChangeRoleScreenState extends State<ChangeRoleScreen> {
  String selectedFilter = "All";

  List<UserModel> usersList = [];
  List<UserModel> showedList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShowUsersCubit>(context).showUsers();
  }

  void filterRequests(String filter) {
    setState(() {
      selectedFilter = filter;
      if (filter == "All") {
        showedList = usersList;
      } else if (filter == "Admin") {
        showedList =
            usersList.where((element) => element.role == 'admin').toList();
      } else if (filter == "Volunteer") {
        showedList =
            usersList.where((element) => element.role == 'volunteer').toList();
      } else if (filter == "User") {
        showedList =
            usersList.where((element) => element.role == 'user').toList();
      }
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<ShowUsersCubit, ShowUsersState>(
      builder: (context, state) {
        if (state is ShowUsersSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            filterRequests(selectedFilter);
          });

          usersList = state.usersList;
          return buildLoadedListWidgets();
        } else if (state is ShowUsersFail) {
          return Column(
            children: [
              const Text(
                "There is an error:",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                state.errmsg,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: buildusersList(),
    );
  }

  Widget buildusersList() {
    return ListView.builder(
      itemCount: showedList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => UserItem(
        userModel: showedList[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarActions: PopupMenuButton<String>(
        color: const Color.fromARGB(255, 60, 53, 104),
        onSelected: filterRequests,
        icon: const Icon(
          Icons.filter_list,
          color: Colors.white,
        ),
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'All',
            child: Text(
              "All",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const PopupMenuItem(
            value: 'Admin',
            child: Text(
              "Admin",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const PopupMenuItem(
            value: 'Volunteer',
            child: Text(
              "Volunteer",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const PopupMenuItem(
            value: 'User',
            child: Text(
              "User",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      appBarTitle: "Change Role",
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: buildBlocWidget(),
      ),
    );
  }
}
