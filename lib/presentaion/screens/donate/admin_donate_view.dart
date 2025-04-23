import 'package:baader/data/cubits/donation_numbers_cubit/donation_numbers_cubit.dart';
import 'package:baader/presentaion/widgets/add_donation_number_sheet.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:baader/presentaion/widgets/donate_number_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDonateView extends StatelessWidget {
  const AdminDonateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonationNumbersCubit, DonationNumbersState>(
      builder: (context, state) {
        if (state is DonationNumbersSuccess) {
          final donateList = state.donationNumbersList;
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  itemCount: donateList.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return DonateNumberItem(
                      curr: donateList[index],
                    );
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ElevatedButton.icon(
                  onPressed: () {
                    showBottomSheet(
                        backgroundColor: const Color.fromARGB(255, 38, 31, 125),
                        context: context,
                        builder: (context) => const AddDonationNumberSheet());
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add New Number"),
                ),
              ],
            ),
          );
        } else if (state is DonationNumbersFail) {
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
}
