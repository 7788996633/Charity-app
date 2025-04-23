import 'package:baader/data/cubits/delete_statistic_cubit/delete_statistic_cubit.dart';
import 'package:baader/data/cubits/show_stat_cubit/show_stat_cubit.dart';
import 'package:baader/data/models/statistics_model.dart';
import 'package:baader/presentaion/widgets/custom_scaffold.dart';
import 'package:baader/presentaion/widgets/statistics_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/cubits/user_cubit/user_cubit.dart';
import '../../../data/cubits/user_role_cubit/user_role_cubit.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late List<StatistcsModel> stList;
  late UserRoleCubit userRoleCubit;

  @override
  void initState() {
    userRoleCubit = UserRoleCubit();
    BlocProvider.of<UserCubit>(context).getUserInfo(userRoleCubit);
    BlocProvider.of<ShowStatCubit>(context).showSt();

    super.initState();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<ShowStatCubit, ShowStatState>(
      builder: (context, state) {
        if (state is ShowStatSuccess) {
          stList = state.st;
          return buildLoadedListWidgets();
        } else if (state is ShowStatFail) {
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
    return buildstList();
  }

  Widget buildstList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            itemCount: stList.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) => Column(
              children: [
                StatisticItem(
                  st: stList[index],
                ),
                BlocBuilder<UserRoleCubit, UserRoleState>(
                  builder: (context, state) {
                    if (state is UserRoleSuperAdmin || state is UserRoleAdmin) {
                      return BlocConsumer<DeleteStatisticCubit,
                          DeleteStatisticState>(
                        listener: (context, state) {
                          if (state is DeleteStatisticSuccess) {
                            BlocProvider.of<ShowStatCubit>(context).showSt();
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor:
                                    const Color.fromARGB(255, 146, 100, 239),
                                content: Text(
                                  state.successmsg,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          } else if (state is DeleteStatisticFail) {
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
                          }
                        },
                        builder: (context, state) {
                          return IconButton(
                            onPressed: () {
                              BlocProvider.of<DeleteStatisticCubit>(context)
                                  .deleteStatistic(stList[index].id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          );
                        },
                      );
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserRoleCubit>.value(
      value: userRoleCubit,
      child: CustomScaffold(
        appBarActions: const Text(""),
        appBarTitle: "Statistics",
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: buildBlocWidget(),
        ),
      ),
    );
  }
}
