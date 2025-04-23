import 'package:baader/data/models/ads_model.dart';
import 'package:baader/presentaion/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

class AdsItem extends StatelessWidget {
  const AdsItem({super.key, required this.adsModel});
  final AdsModel adsModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 31, 25, 107),
      child: Column(
        children: [
          Image.network(
            width: double.infinity,
            adsModel.image,
            height: MediaQuery.of(context).size.height * 0.5,
            fit: BoxFit.fill,
          ),
          CustomListTile(
              icon: const Icon(
                Icons.title,
                color: Colors.white,
              ),
              title: adsModel.title,
              maxlines: 1),
        ],
      ),
    );
    // Card(
    //   color: Colors.black.withOpacity(0.4),
    //   child: Column(
    //     children: [
    //       Image.network(
    //         width: double.infinity,
    //         adsModel.image,
    //         height: 250,
    //         fit: BoxFit.cover,
    //       ),
    //       Text(
    //         adsModel.title,
    //         style: const TextStyle(
    //             fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
    //       ),
    //       Text(
    //         adsModel.description,
    //         style: const TextStyle(
    //             fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
    //       ),
    //     ],
    //   ),
    // );
  }
}
