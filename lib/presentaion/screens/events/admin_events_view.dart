import 'package:baader/data/cubits/delete_event_cubit/delete_event_cubit.dart';
import 'package:baader/data/models/eventmodel.dart';
import 'package:baader/presentaion/screens/events/edit_event_screen.dart';
import 'package:baader/presentaion/widgets/add_event_sheet.dart';
import 'package:baader/presentaion/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminEventsView extends StatelessWidget {
  const AdminEventsView({super.key, required this.events});
  final List<EventModel> events;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteEventCubit, DeleteEventState>(
      listener: (context, state) {
        if (state is DeleteEventSuccess) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 146, 100, 239),
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
        } else if (state is DeleteEventFail) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 146, 100, 239),
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
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                itemCount: events.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      EventItem(
                        currEvent: events[index],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    EditEventScreen(event: events[index]),
                              ));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              BlocProvider.of<DeleteEventCubit>(context)
                                  .deleteEvent(events[index].id);
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showBottomSheet(
                    backgroundColor: const Color.fromARGB(255, 38, 31, 125),
                    context: context,
                    builder: (context) => const AddEventSheet(),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text("Add New Events"),
              ),
            ],
          ),
        );
      },
    );
  }
}
