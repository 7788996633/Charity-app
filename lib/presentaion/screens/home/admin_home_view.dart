import 'package:baader/data/cubits/delete_ads_cubit/delete_ads_cubit.dart';
import 'package:baader/data/cubits/delete_event_cubit/delete_event_cubit.dart';
import 'package:baader/data/models/ads_model.dart';
import 'package:baader/presentaion/widgets/add_ads_sheet.dart';
import 'package:baader/presentaion/widgets/ads_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key, required this.ads});
  final List<AdsModel> ads;

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  int _currentAdIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteAdsCubit, DeleteAdsState>(
      listener: (context, state) {
        if (state is DeleteAdsSuccess) {
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
        } else if (state is DeleteAdsFail) {
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      _currentAdIndex = index;
                    });
                  },
                  itemCount: widget.ads.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        AdsItem(
                          adsModel: widget.ads[index],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                BlocProvider.of<DeleteEventCubit>(context)
                                    .deleteEvent(widget.ads[index].id);
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.ads.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 4),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: _currentAdIndex == index ? 12 : 8,
                    width: _currentAdIndex == index ? 12 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentAdIndex == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                    ),
                  );
                }),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showBottomSheet(
                    backgroundColor: const Color.fromARGB(255, 38, 31, 125),
                    context: context,
                    builder: (context) => const AddAdsSheet(),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text("Add New Ads"),
              ),
            ],
          ),
        );
      },
    );
  }
}
