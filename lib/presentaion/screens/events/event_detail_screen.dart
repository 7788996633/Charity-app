import 'package:baader/data/cubits/add_statistics_cubit/add_statistics_cubit.dart';
import 'package:baader/data/cubits/subscribe_to_event_cubit/subscribe_to_event_cubit.dart';
import 'package:baader/data/cubits/user_cubit/user_cubit.dart';
import 'package:baader/data/cubits/user_role_cubit/user_role_cubit.dart';
import 'package:baader/data/models/eventmodel.dart';
import 'package:baader/presentaion/screens/events/event_requests_screen.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_material_button.dart';
import 'package:baader/presentaion/widgets/custom_scaffold.dart';
import 'package:baader/presentaion/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/custom_list_tile.dart';
import '../../widgets/custom_loading_indicator.dart';
import 'package:intl/intl.dart'; // Import to format date

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key, required this.event});
  final EventModel event;

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  late UserRoleCubit userRoleCubit;
  TextEditingController descController = TextEditingController();
  FocusNode descFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    userRoleCubit = UserRoleCubit();
    BlocProvider.of<UserCubit>(context).getUserInfo(userRoleCubit);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserRoleCubit>.value(
      value: userRoleCubit,
      child: CustomScaffold(
        appBarActions: const Text(""),
        appBarTitle: widget.event.name,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildEventImage(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                CustomContainar(
                  child: Column(
                    children: [
                      _buildEventDescription(),
                      if (widget.event.endDate.isAfter(DateTime.now()))
                        _buildAvailableToText(), // Show available text
                      BlocBuilder<UserRoleCubit, UserRoleState>(
                        builder: (context, roleState) {
                          if (roleState is UserRoleSuperAdmin ||
                              roleState is UserRoleAdmin) {
                            return _buildAdminOrSuperAdminView(roleState);
                          } else if (roleState is UserRoleNormal) {
                            return _buildNormalUserView();
                          } else if (roleState is UserRoleVolunteer) {
                            return _buildVolunteerView();
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventImage() {
    return Image.network(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.45,
      widget.event.image,
      fit: BoxFit.fill,
    );
  }

  Widget _buildEventDescription() {
    return Column(
      children: [
        CustomListTile(
          maxlines: 2,
          icon: const Icon(
            Icons.description,
            color: Colors.white,
            size: 25,
          ),
          title: '${widget.event.description} ',
        ),
        const Divider(color: Colors.white54),
        CustomListTile(
          maxlines: 1,
          icon: const Icon(
            Icons.location_on,
            color: Colors.white,
            size: 25,
          ),
          title: '${widget.event.location} ',
        ),
        const Divider(color: Colors.white54),
      ],
    );
  }

  // Widget to show available date text in green
  Widget _buildAvailableToText() {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.date_range,
            color: Colors.white,
          ),
          title: Text(
            "Available to: ${dateFormat.format(widget.event.endDate)}",
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(color: Colors.white54),
      ],
    );
  }

  Widget _buildAdminOrSuperAdminView(UserRoleState roleState) {
    if (widget.event.endDate.isAfter(DateTime.now())) {
      return Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          if (roleState is UserRoleAdmin) _buildSubscribeButtons(),
          CustomMaterialButton(
            text: "Show requests",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EventRequestsScreen(ev: widget.event),
                ),
              );
            },
          ),
        ],
      );
    } else {
      return Column(
        children: [
          const Text(
            "This event has ended",
            style: TextStyle(fontSize: 30, color: Colors.red),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          _buildAddStatisticsSection(),
        ],
      );
    }
  }

  Widget _buildSubscribeButtons() {
    return BlocConsumer<SubscribeToEventCubit, SubscribeToEventState>(
      listener: (context, state) {
        if (state is SubscribeToEventSuccess) {
          _showDialog(state.sucssessmsg);
        } else if (state is SubscribeToEventFail) {
          _showDialog(state.errmsg);
        }
      },
      builder: (context, state) {
        final userRoleCubit = BlocProvider.of<UserRoleCubit>(context);

        return Column(
          children: [
            CustomMaterialButton(
              text: "Benefit",
              onPressed: () {
                BlocProvider.of<SubscribeToEventCubit>(context)
                    .subscribeToEventAsABen(widget.event.id);
              },
            ),
            if (userRoleCubit.state is! UserRoleNormal)
              CustomMaterialButton(
                text: "Volunteer",
                onPressed: () {
                  BlocProvider.of<SubscribeToEventCubit>(context)
                      .subscribeToEventAsAVol(widget.event.id);
                },
              ),
          ],
        );
      },
    );
  }

  Widget _buildAddStatisticsSection() {
    return BlocConsumer<AddStatisticsCubit, AddStatisticsState>(
      listener: (context, state) {
        if (state is AddStatisticsSuccess) {
          _showDialog(state.successmsg);
        } else if (state is AddStatisticsFail) {
          Navigator.of(context).pop(); // Close the loading dialog
          _showDialog(state.errmsg);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            CustomTextField(
              myController: descController,
              hintText: "Enter your description here",
              labelText: "Description",
              icon: const Icon(Icons.comment, color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your suggestion';
                }
                return null;
              },
              focusNode: descFocusNode,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            CustomMaterialButton(
              text: "Add statistics",
              onPressed: () {
                BlocProvider.of<AddStatisticsCubit>(context)
                    .addSt(widget.event.id, descController.text);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildNormalUserView() {
    return widget.event.endDate.isAfter(DateTime.now())
        ? Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              _buildSubscribeButtons(),
            ],
          )
        : const Text(
            "This event has ended",
            style: TextStyle(fontSize: 30, color: Colors.red),
          );
  }

  Widget _buildVolunteerView() {
    return widget.event.endDate.isAfter(DateTime.now())
        ? Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              _buildSubscribeButtons(),
            ],
          )
        : const Text(
            "This event has ended",
            style: TextStyle(fontSize: 30, color: Colors.red),
          );
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 146, 100, 239),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
