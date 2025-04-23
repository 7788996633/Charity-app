import 'package:baader/presentaion/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:baader/data/models/eventmodel.dart';
import 'package:intl/intl.dart';

import '../screens/events/event_detail_screen.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.currEvent});
  final EventModel currEvent;

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EventDetailScreen(
                  event: currEvent,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 31, 25, 107),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Image.network(
                    currEvent.image,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomListTile(
                      maxlines: 1,
                      icon: const Icon(
                        Icons.title,
                        color: Colors.white,
                        size: 25,
                      ),
                      title: '${currEvent.name} ',
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                        size: 25,
                      ),
                      title: Text(
                        currEvent.endDate.isAfter(DateTime.now())
                            ? "Available to ${dateFormat.format(currEvent.endDate)} "
                            : 'This event is end',
                        style: TextStyle(
                          fontSize: 20,
                          color: currEvent.endDate.isAfter(DateTime.now())
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    );
  }
}
