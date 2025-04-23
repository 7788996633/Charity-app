import 'package:baader/data/cubits/show_user_by_id_cubit/show_user_by_id_cubit.dart';
import 'package:baader/data/models/rate_model.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../screens/profile_screen.dart';

class RateItem extends StatelessWidget {
  const RateItem({
    super.key,
    required this.rate,
  });
  final RateModel rate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowUserByIdCubit()..getUser(rate.commentedUserId),
      child: BlocBuilder<ShowUserByIdCubit, ShowUserByIdState>(
        builder: (context, state) {
          if (state is ShowUserByIdSuccess) {
            final userModel = state.user;
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(userModel: userModel),
                  ),
                );
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.network(
                      width: 50,
                      height: 50,
                      userModel.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 300,
                    child: Card(
                      elevation: 10,
                      color: const Color.fromARGB(255, 119, 116, 181),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${userModel.firstName} ${userModel.lastName}',
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              RatingBarIndicator(
                                rating: rate.rating,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 15,
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            maxLines: 2,
                            rate.comment,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
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
