import 'package:baader/data/cubits/donation_numbers_cubit/donation_numbers_cubit.dart';
import 'package:baader/data/models/donation_numbersmodel.dart';
import 'package:baader/presentaion/screens/donate/admin_donate_view.dart';
import 'package:baader/presentaion/widgets/custom_scaffold.dart';
import 'package:baader/presentaion/widgets/donate_number_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/cubits/user_cubit/user_cubit.dart';
import '../../../data/cubits/user_role_cubit/user_role_cubit.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  late List<DonationNumberModel> donateList;
  late UserRoleCubit userRoleCubit;

  @override
  void initState() {
    userRoleCubit = UserRoleCubit();
    BlocProvider.of<UserCubit>(context).getUserInfo(userRoleCubit);
    super.initState();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<DonationNumbersCubit, DonationNumbersState>(
      builder: (context, state) {
        if (state is DonationNumbersSuccess) {
          donateList = state.donationNumbersList;
          return BlocBuilder<UserRoleCubit, UserRoleState>(
            builder: (context, roleState) {
              if (roleState is UserRoleSuperAdmin) {
                return const AdminDonateView();
              } else if (roleState is UserRoleNormal) {
                return buildLoadedListWidgets();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        } else if (state is DonationNumbersFail) {
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
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: buildDonateList(),
    );
  }

  Widget buildDonateList() {
    return ListView.builder(
      itemCount: donateList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => DonateNumberItem(
        curr: donateList[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserRoleCubit>.value(
      value: userRoleCubit,
      child: CustomScaffold(
        appBarActions: const Text(""),
        appBarTitle: "Donate",
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: buildBlocWidget(),
        ),
      ),
    );
  }
}
