import 'package:baader/data/cubits/show_ads_cubit/show_ads_cubit.dart';
import 'package:baader/data/cubits/user_cubit/user_cubit.dart';
import 'package:baader/data/models/ads_model.dart';
import 'package:baader/presentaion/screens/home/admin_home_view.dart';
import 'package:baader/presentaion/widgets/ads_item.dart';
import 'package:baader/presentaion/widgets/custom_drawer.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/cubits/user_role_cubit/user_role_cubit.dart';
import '../../widgets/custom_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<AdsModel> ads;
  int _currentAdIndex = 0;
  late UserRoleCubit userRoleCubit;

  @override
  void initState() {
    userRoleCubit = UserRoleCubit();

    BlocProvider.of<ShowAdsCubit>(context).showAds();
    BlocProvider.of<UserCubit>(context).getUserInfo(userRoleCubit);

    super.initState();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<ShowAdsCubit, ShowAdsState>(
      builder: (context, state) {
        if (state is ShowAdsSuccess) {
          ads = state.ads;
          return BlocBuilder<UserRoleCubit, UserRoleState>(
            builder: (context, roleState) {
              if (roleState is UserRoleSuperAdmin ||
                  roleState is UserRoleAdmin) {
                return AdminHomeView(
                  ads: ads,
                );
              } else if (roleState is UserRoleNormal ||
                  roleState is UserRoleVolunteer) {
                return buildAds();
              } else {
                return const Center(
                  child: CustomLoadingIndicator(),
                );
              }
            },
          );
        } else if (state is ShowAdsFail) {
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

  Widget buildAds() {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                _currentAdIndex = index;
              });
            },
            itemCount: ads.length,
            itemBuilder: (context, index) {
              return AdsItem(
                adsModel: ads[index],
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(ads.length, (index) {
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
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserRoleCubit>.value(
      value: userRoleCubit,
      child: CustomScaffold(
        drawer: const CustomDrawer(),
        appBarTitle: "Home",
        appBarActions: const Text(""),
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                const Text(
                  "Ads",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                buildBlocWidget(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
