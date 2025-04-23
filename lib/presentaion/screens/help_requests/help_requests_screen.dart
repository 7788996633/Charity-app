import 'package:baader/data/cubits/show_help_requests_cubit/show_help_requests_cubit.dart';
import 'package:baader/data/models/help_request_model.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:baader/presentaion/widgets/help_request_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/custom_scaffold.dart';

class HelpRequestsScreen extends StatefulWidget {
  const HelpRequestsScreen({super.key});

  @override
  State<HelpRequestsScreen> createState() => _HelpRequestsScreenState();
}

class _HelpRequestsScreenState extends State<HelpRequestsScreen> {
  late List<HelpRequestModel> helpRequestsList = [];
  late List<HelpRequestModel> showedRequests = [];
  late List<HelpRequestModel> acceptedRequests = [];
  late List<HelpRequestModel> waitRequests = [];
  String selectedFilter = "All"; // لتخزين الفلتر الحالي

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShowHelpRequestsCubit>(context).showHelpRequests();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<ShowHelpRequestsCubit, ShowHelpRequestsState>(
      builder: (context, state) {
        if (state is ShowHelpRequestsSuccess) {
          helpRequestsList = state.helpreq;
          acceptedRequests = helpRequestsList
              .where((element) => element.requestStatus == 1)
              .toList();
          waitRequests = helpRequestsList
              .where((element) => element.requestStatus == 0)
              .toList();

          // تأجيل استدعاء setState حتى بعد انتهاء البناء
          WidgetsBinding.instance.addPostFrameCallback((_) {
            filterRequests(selectedFilter);
          });

          return buildLoadedListWidgets();
        } else if (state is ShowHelpRequestsFail) {
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
      child: buildHelpRequestList(),
    );
  }

  Widget buildHelpRequestList() {
    return ListView.builder(
      itemCount: showedRequests.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => Column(
        children: [
          HelpRequestItem(
            helpRequestModel: showedRequests[index],
          ),
          const Divider(
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  void filterRequests(String filter) {
    setState(() {
      selectedFilter = filter;
      if (filter == "All") {
        showedRequests = helpRequestsList;
      } else if (filter == "Accepted") {
        showedRequests = acceptedRequests;
      } else if (filter == "Wait") {
        showedRequests = waitRequests;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarActions: PopupMenuButton<String>(
        color: const Color.fromARGB(255, 60, 53, 104),
        icon: const Icon(
          Icons.filter_list,
          color: Colors.white,
        ),
        onSelected: filterRequests,
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: "All",
            child: Text(
              "All",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const PopupMenuItem(
            value: "Accepted",
            child: Text(
              "Accepted",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const PopupMenuItem(
            value: "Wait",
            child: Text(
              "Wait",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      appBarTitle: "Help Requests",
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: buildBlocWidget(),
      ),
    );
  }
}
