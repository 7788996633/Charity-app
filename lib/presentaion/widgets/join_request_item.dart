import 'package:baader/data/cubits/confirm_volunteer_request_cubit/confirm_volunteer_request_cubit.dart';
import 'package:baader/data/cubits/delete_volunteer_request_cubit/delete_volunteer_request_cubit.dart';
import 'package:baader/data/cubits/show_volunteer_requests_cubit/show_volunteer_requests_cubit.dart';
import 'package:baader/data/models/volunteer_request_model.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/cubits/show_user_by_id_cubit/show_user_by_id_cubit.dart';

class JoinRequestItem extends StatefulWidget {
  const JoinRequestItem({super.key, required this.vol});
  final VolunteerRequestModel vol;

  @override
  State<JoinRequestItem> createState() => _JoinRequestItemState();
}

class _JoinRequestItemState extends State<JoinRequestItem> {
  bool showInfo = false;

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    return BlocProvider(
      create: (context) => ShowUserByIdCubit()..getUser(widget.vol.userId),
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
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
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
                        color: Colors.white,
                        size: 30,
                        showInfo
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward,
                      ),
                    ),
                  ),
                  if (showInfo == true)
                    CustomContainar(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Skills: ${widget.vol.skills}",
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            "Studding: ${widget.vol.studding}",
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            "Available Time: ${widget.vol.availableTime}",
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            "Send Time: ${dateFormat.format(widget.vol.volDate)}",
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocConsumer<ConfirmVolunteerRequestCubit,
                                  ConfirmVolunteerRequestState>(
                                listener: (context, state) {
                                  if (state is ConfirmVolunteerRequestSuccess) {
                                    BlocProvider.of<ShowVolunteerRequestsCubit>(
                                            context)
                                        .showVols();
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: const Color.fromARGB(
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
                                      is ConfirmVolunteerRequestFail) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: const Color.fromARGB(
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
                                                  ConfirmVolunteerRequestCubit>(
                                              context)
                                          .confirmVolReq(widget.vol.id);
                                    },
                                    child: const Text(
                                      "Confirm",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              BlocConsumer<DeleteVolunteerRequestCubit,
                                  DeleteVolunteerRequestState>(
                                listener: (context, state) {
                                  if (state is DeleteVolunteerRequestSuccess) {
                                    BlocProvider.of<ShowVolunteerRequestsCubit>(
                                            context)
                                        .showVols();
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: const Color.fromARGB(
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
                                      is DeleteVolunteerRequestFail) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: const Color.fromARGB(
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
                                                  DeleteVolunteerRequestCubit>(
                                              context)
                                          .deleteVolReq(widget.vol.id);
                                    },
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
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
