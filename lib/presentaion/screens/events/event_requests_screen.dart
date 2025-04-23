import 'package:baader/data/cubits/benifit_requests_cubit/benifit_requests_cubit.dart';
import 'package:baader/data/cubits/delete_event_request_cubit/delete_event_request_cubit.dart';
import 'package:baader/data/cubits/event_volunteer_request_cubit/event_volunteer_request_cubit.dart';
import 'package:baader/data/models/eventmodel.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:baader/presentaion/widgets/custom_scaffold.dart';
import 'package:baader/presentaion/widgets/event_requests_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/cubits/confirm_benifit_requests_cubit/confirm_benifit_requests_cubit.dart';
import '../../../data/models/benifit_request_model.dart';

class EventRequestsScreen extends StatefulWidget {
  const EventRequestsScreen({super.key, required this.ev});
  final EventModel ev;
  @override
  State<EventRequestsScreen> createState() => _EventRequestsScreenState();
}

class _EventRequestsScreenState extends State<EventRequestsScreen> {
  bool vol = true;
  late List<EventRequestModel> benList;
  late List<EventRequestModel> volList;

  @override
  void initState() {
    BlocProvider.of<BenifitRequestsCubit>(context).showBinList(widget.ev.id);
    BlocProvider.of<EventVolunteerRequestCubit>(context)
        .showVolList(widget.ev.id);

    super.initState();
  }

  Widget buildBenBlocWidget() {
    return BlocBuilder<BenifitRequestsCubit, BenifitRequestsState>(
      builder: (context, state) {
        if (state is BenifitRequestsSuccess) {
          benList = state.binList;
          if (benList.isNotEmpty) {
            return buildbenList();
          } else {
            return const Center(
              child: Text(
                "There is no benefit.",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            );
          }
        } else if (state is BenifitRequestsFail) {
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

  Widget buildVolBlocWidget() {
    return BlocBuilder<EventVolunteerRequestCubit, EventVolunteerRequestState>(
      builder: (context, state) {
        if (state is EventVolunteerRequestSuccess) {
          volList = state.reqs;
          if (volList.isNotEmpty) {
            return buildVolList();
          } else {
            return const Center(
              child: Text(
                "There are no volunteers.",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            );
          }
        } else if (state is EventVolunteerRequestFail) {
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

  Widget buildbenList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            itemCount: benList.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) => Column(
              children: [
                EventRequestItem(
                  onPressed2: () {
                    BlocProvider.of<DeleteEventRequestCubit>(context)
                        .deleteBenReq(benList[index].id);
                    BlocProvider.of<BenifitRequestsCubit>(context)
                        .showBinList(widget.ev.id);
                  },
                  status: benList[index].benefit,
                  onPressed1: () {
                    BlocProvider.of<ConfirmEventRequestsCubit>(context)
                        .confirmBenReq(benList[index].id);

                    BlocProvider.of<BenifitRequestsCubit>(context)
                        .showBinList(widget.ev.id);
                  },
                  ev: benList[index],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget buildVolList() {
    return Column(
      children: [
        ListView.builder(
          itemCount: volList.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) => Column(
            children: [
              EventRequestItem(
                onPressed2: () {
                  BlocProvider.of<DeleteEventRequestCubit>(context)
                      .deleteVolReq(volList[index].id);

                  BlocProvider.of<EventVolunteerRequestCubit>(context)
                      .showVolList(widget.ev.id);
                },
                status: volList[index].volunteering,
                onPressed1: () {
                  BlocProvider.of<ConfirmEventRequestsCubit>(context)
                      .confirmVolReq(volList[index].id);

                  BlocProvider.of<EventVolunteerRequestCubit>(context)
                      .showVolList(widget.ev.id);
                },
                ev: volList[index],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                color:
                    vol ? const Color.fromARGB(255, 48, 48, 48) : Colors.white,
                onPressed: () {
                  setState(() {
                    vol = false;
                  });
                },
                child: Text(
                  "Beneficiaries",
                  style: TextStyle(
                      fontSize: vol ? 25 : 30,
                      color: vol
                          ? Colors.white
                          : const Color.fromARGB(255, 24, 22, 110)),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              MaterialButton(
                color:
                    vol ? Colors.white : const Color.fromARGB(255, 48, 48, 48),
                onPressed: () {
                  setState(() {
                    vol = true;
                  });
                },
                child: Text(
                  "Volunteers",
                  style: TextStyle(
                      fontSize: vol ? 30 : 25,
                      color: vol
                          ? const Color.fromARGB(255, 24, 22, 110)
                          : Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          vol ? buildVolBlocWidget() : buildBenBlocWidget(),
        ],
      ),
      appBarTitle: 'Requests',
      appBarActions: const Text(""),
    );
  }
}
