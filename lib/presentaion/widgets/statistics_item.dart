import 'package:baader/data/cubits/show_event_by_id_cubit/show_event_by_id_cubit.dart';
import 'package:baader/data/models/statistics_model.dart';
import 'package:baader/presentaion/screens/events/event_detail_screen.dart';
import 'package:baader/presentaion/widgets/custom_list_tile.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticItem extends StatelessWidget {
  const StatisticItem({
    super.key,
    required this.st,
  });
  final StatistcsModel st;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowEventByIdCubit()..getEvent(st.eventId),
      child: BlocBuilder<ShowEventByIdCubit, ShowEventByIdState>(
        builder: (context, state) {
          if (state is ShowEventByIdSuccess) {
            final eventModel = state.ev;
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            EventDetailScreen(event: eventModel),
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
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.4,
                            eventModel.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                        CustomListTile(
                          maxlines: 1,
                          icon: const Icon(
                            Icons.title,
                            color: Colors.white,
                            size: 25,
                          ),
                          title: '${eventModel.name} ',
                        ),
                        CustomListTile(
                          maxlines: 5,
                          icon: const Icon(
                            Icons.bar_chart,
                            color: Colors.white,
                            size: 25,
                          ),
                          title: '${st.description} ',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is ShowEventByIdFail) {
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
