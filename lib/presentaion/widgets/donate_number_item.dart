import 'package:baader/data/models/donation_numbersmodel.dart';
import 'package:baader/presentaion/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

class DonateNumberItem extends StatelessWidget {
  const DonateNumberItem({super.key, required this.curr});
  final DonationNumberModel curr;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: const Color.fromARGB(255, 31, 25, 107),
      child: CustomListTile(
          icon: const Icon(
            Icons.phone,
            size: 25,
            color: Colors.white,
          ),
          title: curr.phone.toString(),
          maxlines: 1),
    );
  }
}
