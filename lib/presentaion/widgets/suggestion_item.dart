import 'package:baader/data/cubits/confirm_suggestion_cubit/confirm_suggestion_cubit.dart';
import 'package:baader/data/models/suggestionmodel.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cubits/delete_suggestion_cubit_/delete_suggestion_cubit.dart';
import '../../data/cubits/show_user_by_id_cubit/show_user_by_id_cubit.dart';

class SuggestionItem extends StatelessWidget {
  const SuggestionItem({super.key, required this.sugg});
  final SuggestionModel sugg;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowUserByIdCubit()..getUser(sugg.userId!),
      child: BlocBuilder<ShowUserByIdCubit, ShowUserByIdState>(
        builder: (context, state) {
          if (state is ShowUserByIdSuccess) {
            final userModel = state.user;
            return Card(
              elevation: 10,
              color: const Color.fromARGB(255, 31, 25, 107),
              child: ListTile(
                trailing: sugg.status == 0
                    ? BlocConsumer<ConfirmSuggestionCubit,
                        ConfirmSuggestionState>(
                        listener: (context, state) {
                          if (state is ConfirmSuggestionSuccess) {
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
                          } else if (state is ConfirmSuggestionFail) {
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
                          return PopupMenuButton(
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {
                                  BlocProvider.of<ConfirmSuggestionCubit>(
                                          context)
                                      .confirmSuggestion(sugg.id);
                                },
                                child: const Text(
                                  "Confirm",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                child:                               BlocConsumer<DeleteSuggestionCubit,
                                    DeleteSuggestionState>(

                                  listener: (context, state) {
                                    if (state is DeleteSuggestionSuccess) {
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
                                    } else if (state is DeleteSuggestionFail) {
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
                                    return MaterialButton(
                                      onPressed: () {
                                        BlocProvider.of<DeleteSuggestionCubit>(
                                                context)
                                            .deleteSugg(sugg.id);
                                      },
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : const Text(
                        "accepted",
                        style: TextStyle(
                          color: Colors.greenAccent,
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
                      color:
                          sugg.status == 0 ? Colors.white : Colors.greenAccent,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  sugg.desc!,
                  style: TextStyle(
                    fontSize: 20,
                    color: sugg.status == 0 ? Colors.white : Colors.greenAccent,
                  ),
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
