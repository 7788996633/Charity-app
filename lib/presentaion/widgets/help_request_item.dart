import 'package:baader/data/cubits/confirm_help_request_cubit/confirm_help_request_cubit.dart';
import 'package:baader/data/cubits/show_help_requests_cubit/show_help_requests_cubit.dart';
import 'package:baader/data/models/help_request_model.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/cubits/delete_help_request_cubit/delete_help_request_cubit.dart';
import '../../data/cubits/show_user_by_id_cubit/show_user_by_id_cubit.dart';

class HelpRequestItem extends StatefulWidget {
  const HelpRequestItem({super.key, required this.helpRequestModel});
  final HelpRequestModel helpRequestModel;

  @override
  State<HelpRequestItem> createState() => _HelpRequestItemState();
}

class _HelpRequestItemState extends State<HelpRequestItem> {
  bool showInfo = false;

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    return BlocProvider(
      create: (context) =>
          ShowUserByIdCubit()..getUser(widget.helpRequestModel.userId),
      child: BlocBuilder<ShowUserByIdCubit, ShowUserByIdState>(
        builder: (context, state) {
          if (state is ShowUserByIdSuccess) {
            final userModel = state.user;
            return Card(
              elevation: 10,
              color: const Color.fromARGB(255, 31, 25, 107),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      '${userModel.firstName} ${userModel.lastName}',
                      style: TextStyle(
                          fontSize: 30,
                          color: widget.helpRequestModel.requestStatus == 1
                              ? Colors.greenAccent
                              : Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        userModel.image,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          showInfo = !showInfo;
                        });
                      },
                      icon: Icon(
                        color: widget.helpRequestModel.requestStatus == 1
                            ? Colors.greenAccent
                            : Colors.white,
                        size: 30,
                        showInfo
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  if (showInfo == true)
                    CustomContainar(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Situation :${widget.helpRequestModel.description}",
                              style: TextStyle(
                                  fontSize: 25,
                                  color:
                                      widget.helpRequestModel.requestStatus == 1
                                          ? Colors.greenAccent
                                          : Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              "City :${widget.helpRequestModel.city}",
                              style: TextStyle(
                                  fontSize: 25,
                                  color:
                                      widget.helpRequestModel.requestStatus == 1
                                          ? Colors.greenAccent
                                          : Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              "Street :${widget.helpRequestModel.street}",
                              style: TextStyle(
                                  fontSize: 25,
                                  color:
                                      widget.helpRequestModel.requestStatus == 1
                                          ? Colors.greenAccent
                                          : Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              "Neighborhood :${widget.helpRequestModel.neighborhood}",
                              style: TextStyle(
                                  fontSize: 25,
                                  color:
                                      widget.helpRequestModel.requestStatus == 1
                                          ? Colors.greenAccent
                                          : Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              "Phone :${userModel.phone}",
                              style: TextStyle(
                                  fontSize: 25,
                                  color:
                                      widget.helpRequestModel.requestStatus == 1
                                          ? Colors.greenAccent
                                          : Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              "Date :${dateFormat.format(widget.helpRequestModel.createDate)}",
                              style: TextStyle(
                                  fontSize: 25,
                                  color:
                                      widget.helpRequestModel.requestStatus == 1
                                          ? Colors.greenAccent
                                          : Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            if (widget.helpRequestModel.requestStatus == 1)
                              const Text(
                                "This help request is accepted",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold),
                              )
                            else
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocConsumer<ConfirmHelpRequestCubit,
                                      ConfirmHelpRequestState>(
                                    listener: (context, state) {
                                      if (state is ConfirmHelpRequestSuccess) {
                                        BlocProvider.of<ShowHelpRequestsCubit>(
                                                context)
                                            .showHelpRequests();
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 146, 100, 239),
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
                                      } else if (state
                                          is ConfirmHelpRequestFail) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 146, 100, 239),
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
                                      return ElevatedButton(
                                        onPressed: () {
                                          BlocProvider.of<
                                                      ConfirmHelpRequestCubit>(
                                                  context)
                                              .confirmHelpRequest(
                                                  widget.helpRequestModel.id);
                                        },
                                        child: const Text(
                                          "Confirm",
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  BlocConsumer<DeleteHelpRequestCubit,
                                      DeleteHelpRequestState>(
                                    listener: (context, state) {
                                      if (state is DeleteHelpRequestSuccess) {
                                        BlocProvider.of<ShowHelpRequestsCubit>(
                                                context)
                                            .showHelpRequests();
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 146, 100, 239),
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
                                      } else if (state
                                          is DeleteHelpRequestFail) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 146, 100, 239),
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
                                      return ElevatedButton(
                                        onPressed: () {
                                          BlocProvider.of<
                                                      DeleteHelpRequestCubit>(
                                                  context)
                                              .deleteHelpRequest(
                                                  widget.helpRequestModel.id);
                                        },
                                        child: const Text(
                                          "Delete",
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          } else if (state is ShowUserByIdFail) {
            return Center(
              child: Text(state.errmsg),
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
