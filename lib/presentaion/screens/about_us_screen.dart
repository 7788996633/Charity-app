import 'package:baader/constants.dart';
import 'package:baader/data/cubits/show_our_team_cubit/show_our_team_cubit.dart';
import 'package:baader/data/models/usermodel.dart';
import 'package:baader/presentaion/screens/join/join_screen.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_material_button.dart';
import 'package:baader/presentaion/widgets/custom_scaffold.dart';
import 'package:baader/presentaion/widgets/team_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cubits/user_cubit/user_cubit.dart';
import '../../data/cubits/user_role_cubit/user_role_cubit.dart';
import '../widgets/custom_loading_indicator.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  late UserRoleCubit userRoleCubit;
  @override
  void initState() {
    super.initState();
    userRoleCubit = UserRoleCubit();
    BlocProvider.of<UserCubit>(context).getUserInfo(userRoleCubit);
    BlocProvider.of<ShowOurTeamCubit>(context).showOurTeam();
  }

  final ScrollController _scrollController = ScrollController();

  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  Widget buildTeamList() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: teamList.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) => TeamItem(
                userModel: teamList[index],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  late List<UserModel> teamList;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserRoleCubit>.value(
      value: userRoleCubit,
      child: CustomScaffold(
          appBarActions: const Text(""),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: BlocBuilder<UserRoleCubit, UserRoleState>(
                builder: (context, roleState) {
                  if (roleState is UserRoleSuperAdmin ||
                      roleState is UserRoleAdmin ||
                      roleState is UserRoleVolunteer) {
                    return Column(
                      children: [
                        Image.asset(
                            width: double.infinity,
                            fit: BoxFit.fill,
                            height: MediaQuery.of(context).size.height * 0.4,
                            'assets/images/logo1.png'),
                        CustomContainar(
                          child: Column(
                            children: [
                              Text(
                                'Welcome to Baader project for development \nDiscover the impact of our community.',
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: changeColors('text'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Column(
                            children: [
                              const Text(
                                'About the Association',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              const Text(
                                'Bader Association is a non-profit organization aimed at helping those in need and improving community conditions through various voluntary programs and initiatives.',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              const Text(
                                'Our mission',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text(
                                'Empowering individuals through charitable events and educational resources, Charity connect is dedicated to fostering a culture of giving back and learning.',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: changeColors('text'),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              const Text(
                                'Our Goals',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              const Text(
                                '1. Helping those in need.\n2. Improving living conditions.\n3. Promoting education and health.\n4. Providing volunteering opportunities.',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              const Text(
                                'Our Team',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              BlocBuilder<ShowOurTeamCubit, ShowOurTeamState>(
                                builder: (context, state) {
                                  if (state is ShowOurTeamSuccess) {
                                    teamList = state.teamList;
                                    return buildTeamList();
                                  } else if (state is ShowOurTeamFail) {
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
                                      child: CustomLoadingIndicator(),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (roleState is UserRoleNormal) {
                    return Column(
                      children: [
                        CustomContainar(
                          child: Column(
                            children: [
                              // Image.network(
                              //     fit: BoxFit.contain,
                              //     height: 250,
                              //     'https://clipground.com/images/each-other-clipart-8.jpg'),
                              Text(
                                'Discover the impact of our community.',
                                style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  color: changeColors('text'),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ListTile(
                                title: Text(
                                  'Join us in making a difference together.',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: changeColors('text'),
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.arrow_downward,
                                    color: changeColors('text'),
                                  ),
                                  onPressed: _scrollToEnd,
                                ),
                              ),
                              const SizedBox(
                                height: 22,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Column(
                            children: [
                              const Text(
                                'About the Association',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Bader Association is a non-profit organization aimed at helping those in need and improving community conditions through various voluntary programs and initiatives.',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Our mission',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Empowering individuals through charitable events and educational resources, Charity connect is dedicated to fostering a culture of giving back and learning.',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: changeColors('text'),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Our Goals',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                '1. Helping those in need.\n2. Improving living conditions.\n3. Promoting education and health.\n4. Providing volunteering opportunities.',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'Our Team',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              BlocBuilder<ShowOurTeamCubit, ShowOurTeamState>(
                                builder: (context, state) {
                                  if (state is ShowOurTeamSuccess) {
                                    teamList = state.teamList;
                                    return buildTeamList();
                                  } else if (state is ShowOurTeamFail) {
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
                                      child: CustomLoadingIndicator(),
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        CustomContainar(
                          child: Column(
                            children: [
                              Text(
                                'Join us today',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: changeColors('text'),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Start making an impact without any commitments, Get involved now.',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: changeColors('text'),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomMaterialButton(
                                text: "Join us",
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const JoinScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
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
          appBarTitle: "About Us"),
    );
  }
}
