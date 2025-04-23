import 'package:baader/data/cubits/show_volunteer_requests_cubit/show_volunteer_requests_cubit.dart';
import 'package:baader/data/models/volunteer_request_model.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:baader/presentaion/widgets/join_request_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/custom_scaffold.dart';

class JoinRequestsScreen extends StatefulWidget {
  const JoinRequestsScreen({super.key});

  @override
  State<JoinRequestsScreen> createState() => _JoinRequestsScreenState();
}

class _JoinRequestsScreenState extends State<JoinRequestsScreen> {
  late List<VolunteerRequestModel> vols;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShowVolunteerRequestsCubit>(context).showVols();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<ShowVolunteerRequestsCubit, ShowVolunteerRequestsState>(
      builder: (context, state) {
        if (state is ShowVolunteerRequestsSuccess) {
          vols = state.vols;
          return buildLoadedListWidgets();
        } else if (state is ShowVolunteerRequestsFail) {
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
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildvols(),
        ],
      ),
    );
  }

  Widget buildvols() {
    return Column(
      children: [
        ListView.builder(
          itemCount: vols.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) => JoinRequestItem(
            vol: vols[index],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarActions: PopupMenuButton(
        color: Colors.blue,
        icon: const Icon(
          Icons.filter_list,
          color: Colors.white,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: () {},
            child: const Text("All"),
          ),
          PopupMenuItem(
            onTap: () {},
            child: const Text("Family"),
          ),
          PopupMenuItem(
            onTap: () {},
            child: const Text("Medical"),
          ),
        ],
      ),
      appBarTitle: "Join requests",
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: buildBlocWidget(),
      ),
    );
  }
}
