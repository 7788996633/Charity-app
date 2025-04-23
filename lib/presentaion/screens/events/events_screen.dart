import 'package:baader/data/models/eventmodel.dart';
import 'package:baader/presentaion/screens/events/admin_events_view.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:baader/presentaion/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/cubits/events_cubit/events_cubit.dart';
import '../../../data/cubits/user_cubit/user_cubit.dart';
import '../../../data/cubits/user_role_cubit/user_role_cubit.dart';
import '../../widgets/custom_scaffold.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late UserRoleCubit userRoleCubit;

  @override
  void initState() {
    super.initState();
    userRoleCubit = UserRoleCubit();
    BlocProvider.of<UserCubit>(context).getUserInfo(userRoleCubit);
    BlocProvider.of<EventsCubit>(context).getAllEvents();
  }

  late List<EventModel> eventsList = [];
  late List<EventModel> showedEvents = [];
  String selectedFilter = "All";
  Widget buildBlocWidget() {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        if (state is EventSuccess) {
          eventsList = state.ev;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            filterRequests(selectedFilter);
          });

          return BlocBuilder<UserRoleCubit, UserRoleState>(
            builder: (context, roleState) {
              if (roleState is UserRoleSuperAdmin ||
                  roleState is UserRoleAdmin) {
                return AdminEventsView(
                  events: showedEvents,
                );
              } else if (roleState is UserRoleNormal ||
                  roleState is UserRoleVolunteer) {
                return buildEventsList();
              } else {
                return const Center(
                  child: CustomLoadingIndicator(),
                );
              }
            },
          );
        } else if (state is EventFail) {
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

  Widget buildEventsList() {
    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: showedEvents.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) => EventItem(
          currEvent: showedEvents[index],
        ),
      ),
    );
  }

  void filterRequests(String filter) {
    setState(() {
      selectedFilter = filter;
      if (filter == "All") {
        showedEvents = eventsList;
      } else if (filter == "Available") {
        showedEvents = eventsList
            .where(
              (element) => element.endDate.isAfter(
                DateTime.now(),
              ),
            )
            .toList();
      } else if (filter == "Ended") {
        showedEvents = eventsList
            .where(
              (element) => element.endDate.isBefore(
                DateTime.now(),
              ),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserRoleCubit>.value(
      value: userRoleCubit,
      child: CustomScaffold(
        appBarActions: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: EventSearchDelegate(eventsList),
                );
              },
            ),
            PopupMenuButton<String>(
              color: const Color.fromARGB(255, 60, 53, 104),
              onSelected: filterRequests,
              icon: const Icon(
                Icons.filter_list_outlined,
                color: Colors.white,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'All',
                  child: Text(
                    'All',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 'Available',
                  child: Text(
                    'Available',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 'Ended',
                  child: Text(
                    'Ended',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: buildBlocWidget(),
        ),
        appBarTitle: 'Events',
      ),
    );
  }
}

class EventSearchDelegate extends SearchDelegate {
  final List<EventModel> events;

  EventSearchDelegate(this.events);
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 21, 8, 40),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Colors.white),
      ),
      cardColor: Colors.white,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = events
        .where(
            (event) => event.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 21, 8, 40),
            Color.fromARGB(255, 9, 5, 56),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return EventItem(
            currEvent: results[index],
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = events
        .where(
            (event) => event.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 21, 8, 40),
            Color.fromARGB(255, 9, 5, 56),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(
                  suggestions[index].name,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  query = suggestions[index].name;
                  showResults(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
