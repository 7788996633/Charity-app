import 'package:baader/data/cubits/logout_cubit/logout_cubit.dart';
import 'package:baader/data/cubits/user_cubit/user_cubit.dart';
import 'package:baader/presentaion/screens/about_us_screen.dart';
import 'package:baader/presentaion/screens/articles/saved_articles_screen.dart';
import 'package:baader/presentaion/screens/change_role_screen.dart';
import 'package:baader/presentaion/screens/donate/donate_screen.dart';
import 'package:baader/presentaion/screens/help_requests/help_requests_screen.dart';
import 'package:baader/presentaion/screens/profile_screen.dart';
import 'package:baader/presentaion/screens/help_requests/submit_help_request_screen.dart';
import 'package:baader/presentaion/screens/join/join_requests_screen.dart';
import 'package:baader/presentaion/screens/auth/login_screen.dart';
import 'package:baader/presentaion/screens/suggestions/suggestions_screen.dart';
import 'package:baader/presentaion/widgets/custom_list_tile.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/helper/api.dart';
import '../../data/cubits/user_role_cubit/user_role_cubit.dart';
import '../../data/models/usermodel.dart';
import '../screens/join/join_screen.dart';
import '../screens/suggestions/add_sugg_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late UserModel userModel;
  late UserRoleCubit userRoleCubit;

  @override
  void initState() {
    super.initState();
    userRoleCubit = UserRoleCubit();
    BlocProvider.of<UserCubit>(context).getUserInfo(userRoleCubit);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserRoleCubit>.value(
      value: userRoleCubit,
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 21, 8, 40),
                Color.fromARGB(255, 51, 49, 128),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: BlocBuilder<UserRoleCubit, UserRoleState>(
              builder: (context, state) {
                if (state is UserRoleSuperAdmin) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          if (state is UserSuccess) {
                            userModel = state.userModel;
                            return Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: Image.network(
                                    width: 70,
                                    height: 70,
                                    '${Api().myUrl}pictures/${userModel.image}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  userModel.firstName,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        title: "Profile",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                userModel: userModel,
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.bookmark_rounded,
                          color: Colors.white,
                        ),
                        title: "Saved articles",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SavedArticlesScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.photo_library,
                          color: Colors.white,
                        ),
                        title: "Gallery",
                        onTap: () {},
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.comment,
                          color: Colors.white,
                        ),
                        title: "Suggestions",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SuggestionsScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.handshake,
                          color: Colors.white,
                        ),
                        title: "Join requests",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const JoinRequestsScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.all_inclusive_sharp,
                          color: Colors.white,
                        ),
                        title: "Help requests",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const HelpRequestsScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.groups,
                          color: Colors.white,
                        ),
                        title: "Users",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ChangeRoleScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.volunteer_activism,
                          color: Colors.white,
                        ),
                        title: "Donate",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const DonateScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                        title: "About us",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AboutUsScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      BlocConsumer<LogoutCubit, LogoutState>(
                        listener: (context, state) {
                          if (state is LogoutSuccess) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                backgroundColor:
                                    Color.fromARGB(255, 146, 100, 239),
                                content: Text(
                                  "Logout success",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          } else if (state is LogoutFail) {
                            Navigator.of(context)
                                .pop(); // Close the loading dialog
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor:
                                    const Color.fromARGB(255, 146, 100, 239),
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
                          } else {
                            const Center(
                              child: CustomLoadingIndicator(),
                            );
                          }
                        },
                        builder: (context, state) {
                          return CustomListTile(
                            maxlines: 1,
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            title: "Logout",
                            onTap: () {
                              BlocProvider.of<LogoutCubit>(context).logOut();
                            },
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                    ],
                  );
                } else if (state is UserRoleAdmin) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          if (state is UserSuccess) {
                            userModel = state.userModel;
                            return Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: Image.network(
                                    width: 70,
                                    height: 70,
                                    '${Api().myUrl}pictures/${userModel.image}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  userModel.firstName,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        title: "Profile",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                userModel: userModel,
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.bookmark_rounded,
                          color: Colors.white,
                        ),
                        title: "Saved articles",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SavedArticlesScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.photo_library,
                          color: Colors.white,
                        ),
                        title: "Gallery",
                        onTap: () {},
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.handshake,
                          color: Colors.white,
                        ),
                        title: "Join requests",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const JoinRequestsScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.all_inclusive_sharp,
                          color: Colors.white,
                        ),
                        title: "Help requests",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const HelpRequestsScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.all_inclusive_sharp,
                          color: Colors.white,
                        ),
                        title: "submit a help request",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SubmitHelpRequestScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.comment,
                          color: Colors.white,
                        ),
                        title: "Add a suggestion",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AddSuggestionScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.all_inclusive_sharp,
                          color: Colors.white,
                        ),
                        title: "submit a help request",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SubmitHelpRequestScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.comment,
                          color: Colors.white,
                        ),
                        title: "Suggestions",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SuggestionsScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.handshake,
                          color: Colors.white,
                        ),
                        title: "Join requests",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const JoinRequestsScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.volunteer_activism,
                          color: Colors.white,
                        ),
                        title: "Donate",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const DonateScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                        title: "About us",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AboutUsScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      BlocConsumer<LogoutCubit, LogoutState>(
                        listener: (context, state) {
                          if (state is LogoutSuccess) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                backgroundColor:
                                    Color.fromARGB(255, 146, 100, 239),
                                content: Text(
                                  "Logout success",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          } else if (state is LogoutFail) {
                            Navigator.of(context)
                                .pop(); // Close the loading dialog
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor:
                                    const Color.fromARGB(255, 146, 100, 239),
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
                          } else {
                            const Center(
                              child: CustomLoadingIndicator(),
                            );
                          }
                        },
                        builder: (context, state) {
                          return CustomListTile(
                            maxlines: 1,
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            title: "Logout",
                            onTap: () {
                              BlocProvider.of<LogoutCubit>(context).logOut();
                            },
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                    ],
                  );
                } else if (state is UserRoleVolunteer) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          if (state is UserSuccess) {
                            userModel = state.userModel;
                            return Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: Image.network(
                                    width: 70,
                                    height: 70,
                                    '${Api().myUrl}pictures/${userModel.image}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  userModel.firstName,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        title: "Profile",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                userModel: userModel,
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.bookmark_rounded,
                          color: Colors.white,
                        ),
                        title: "Saved articles",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SavedArticlesScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.photo_library,
                          color: Colors.white,
                        ),
                        title: "Gallery",
                        onTap: () {},
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.all_inclusive_sharp,
                          color: Colors.white,
                        ),
                        title: "submit a help request",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SubmitHelpRequestScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.comment,
                          color: Colors.white,
                        ),
                        title: "Add a suggestion",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AddSuggestionScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.volunteer_activism,
                          color: Colors.white,
                        ),
                        title: "Donate",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const DonateScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                        title: "About us",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AboutUsScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      BlocConsumer<LogoutCubit, LogoutState>(
                        listener: (context, state) {
                          if (state is LogoutSuccess) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                backgroundColor:
                                    Color.fromARGB(255, 146, 100, 239),
                                content: Text(
                                  "Logout success",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          } else if (state is LogoutFail) {
                            Navigator.of(context)
                                .pop(); // Close the loading dialog
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor:
                                    const Color.fromARGB(255, 146, 100, 239),
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
                          } else {
                            const Center(
                              child: CustomLoadingIndicator(),
                            );
                          }
                        },
                        builder: (context, state) {
                          return CustomListTile(
                            maxlines: 1,
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            title: "Logout",
                            onTap: () {
                              BlocProvider.of<LogoutCubit>(context).logOut();
                            },
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                    ],
                  );
                } else if (state is UserRoleNormal) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          if (state is UserSuccess) {
                            userModel = state.userModel;
                            return Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: Image.network(
                                    width: 70,
                                    height: 70,
                                    '${Api().myUrl}pictures/${userModel.image}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                Text(
                                  userModel.firstName,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        title: "Profile",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                userModel: userModel,
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.bookmark_rounded,
                          color: Colors.white,
                        ),
                        title: "Saved articles",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SavedArticlesScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.photo_library,
                          color: Colors.white,
                        ),
                        title: "Gallery",
                        onTap: () {},
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.handshake,
                          color: Colors.white,
                        ),
                        title: "Join us",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const JoinScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.all_inclusive_sharp,
                          color: Colors.white,
                        ),
                        title: "submit a help request",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SubmitHelpRequestScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.comment,
                          color: Colors.white,
                        ),
                        title: "Add a suggestion",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AddSuggestionScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.volunteer_activism,
                          color: Colors.white,
                        ),
                        title: "Donate",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const DonateScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      CustomListTile(
                        maxlines: 1,
                        icon: const Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                        title: "About us",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AboutUsScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
                      ),
                      BlocConsumer<LogoutCubit, LogoutState>(
                        listener: (context, state) {
                          if (state is LogoutSuccess) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                backgroundColor:
                                    Color.fromARGB(255, 146, 100, 239),
                                content: Text(
                                  "Logout success",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          } else if (state is LogoutFail) {
                            Navigator.of(context)
                                .pop(); // Close the loading dialog
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor:
                                    const Color.fromARGB(255, 146, 100, 239),
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
                          } else {
                            const Center(
                              child: CustomLoadingIndicator(),
                            );
                          }
                        },
                        builder: (context, state) {
                          return CustomListTile(
                            maxlines: 1,
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            title: "Logout",
                            onTap: () {
                              BlocProvider.of<LogoutCubit>(context).logOut();
                            },
                          );
                        },
                      ),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.black,
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
          ),
        ),
      ),
    );
  }
}
