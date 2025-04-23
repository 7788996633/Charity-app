import 'package:baader/data/cubits/show_user_by_id_cubit/show_user_by_id_cubit.dart';
import 'package:baader/data/models/benifit_request_model.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cubits/confirm_benifit_requests_cubit/confirm_benifit_requests_cubit.dart';
import '../../data/cubits/delete_event_request_cubit/delete_event_request_cubit.dart';

class EventRequestItem extends StatelessWidget {
  const EventRequestItem(
      {super.key,
      required this.ev,
      required this.onPressed1,
      required this.status,
      required this.onPressed2});
  final EventRequestModel ev;
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;

  final int status;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowUserByIdCubit()..getUser(ev.userId),
      child: BlocBuilder<ShowUserByIdCubit, ShowUserByIdState>(
        builder: (context, state) {
          if (state is ShowUserByIdSuccess) {
            final userModel = state.user;
            return Card(
              elevation: 10,
              color: const Color.fromARGB(255, 31, 25, 107),
              child: ListTile(
                trailing: status == 0
                    ? BlocConsumer<ConfirmEventRequestsCubit,
                        ConfirmEventRequestsState>(
                        listener: (context, state) {
                          if (state is ConfirmEventRequestsSuccess) {
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
                          } else if (state is ConfirmEventRequestsFail) {
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
                          return BlocConsumer<DeleteEventRequestCubit,
                              DeleteEventRequestState>(
                            listener: (context, state) {
                              if (state is DeleteEventRequestsSuccess) {
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
                              } else if (state is DeleteEventRequestsFail) {
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
                              return PopupMenuButton(
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: MaterialButton(
                                      onPressed: onPressed1,
                                      child: const Text(
                                        "Confirm",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: MaterialButton(
                                      onPressed: onPressed2,
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )
                    : Text(
                        "accepted",
                        style: TextStyle(
                          color:
                              status == 0 ? Colors.white : Colors.greenAccent,
                        ),
                      ),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    userModel.image,
                  ),
                ),
                title: Text(
                  '${userModel.firstName} ${userModel.lastName}',
                  style: TextStyle(
                      fontSize: 25,
                      color: status == 0 ? Colors.white : Colors.greenAccent,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  userModel.role,
                  style: TextStyle(
                      fontSize: 25,
                      color: status == 0 ? Colors.white : Colors.greenAccent,
                      fontWeight: FontWeight.bold),
                ),
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
