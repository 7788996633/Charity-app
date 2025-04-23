import 'package:baader/data/cubits/rate_cubit/rate_cubit.dart';
import 'package:baader/data/cubits/show_user_rate_cubit/show_user_rate_cubit.dart';
import 'package:baader/data/models/rate_model.dart';
import 'package:baader/data/models/usermodel.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_material_button.dart';
import 'package:baader/presentaion/widgets/custom_scaffold.dart';
import 'package:baader/presentaion/widgets/custom_text_field.dart';
import 'package:baader/presentaion/widgets/rate_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../widgets/custom_loading_indicator.dart';
import '../../data/cubits/user_cubit/user_cubit.dart';
import '../../data/cubits/user_role_cubit/user_role_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late List<RateModel> rates = [];
  final TextEditingController commentController = TextEditingController();
  final FocusNode cF = FocusNode();
  double rating = 0;

  late ShowUserRateCubit _showUserRateCubit;
  late UserCubit _userCubit;
  bool isMyProfile = false;

  @override
  void initState() {
    super.initState();
    _showUserRateCubit = ShowUserRateCubit();
    _userCubit = BlocProvider.of<UserCubit>(context);

    _userCubit.getUserInfo(UserRoleCubit());

    _userCubit.stream.listen((state) {
      if (state is UserSuccess) {
        isMyProfile = widget.userModel.id == state.userModel.id;
        _showUserRateCubit.showRates(widget.userModel.id);
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _showUserRateCubit.close();
    super.dispose();
  }

  Widget buildRates() {
    return rates.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rates.length,
            itemBuilder: (context, index) => RateItem(rate: rates[index]),
          )
        : const Text(
            'No comments available',
            style: TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "${widget.userModel.firstName} Profile",
      appBarActions: const SizedBox.shrink(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.network(
                widget.userModel.image,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "${widget.userModel.firstName} ${widget.userModel.lastName}",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            CustomContainar(
              child: Column(
                children: [
                  _buildInfoTile(
                    icon: Icons.person,
                    label:
                        "${widget.userModel.firstName} ${widget.userModel.lastName}",
                  ),
                  const Divider(color: Colors.white54),
                  _buildInfoTile(
                    icon: Icons.phone,
                    label: widget.userModel.phone.toString(),
                  ),
                  const Divider(color: Colors.white54),
                  _buildInfoTile(
                    icon: Icons.email,
                    label: widget.userModel.email,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (widget.userModel.role != 'user') _buildCommentsSection(),
          ],
        ),
      ),
    );
  }

  ListTile _buildInfoTile({required IconData icon, required String label}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCommentsSection() {
    return CustomContainar(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Comments",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          BlocProvider.value(
            value: _showUserRateCubit,
            child: BlocBuilder<ShowUserRateCubit, ShowUserRateState>(
              builder: (context, state) {
                if (state is ShowUserRateSuccess) {
                  rates = state.rates;
                  return buildRates();
                } else if (state is ShowUserRateFail) {
                  return _buildError(state.errmsg);
                } else {
                  return const Center(child: CustomLoadingIndicator());
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          BlocConsumer<RateCubit, RateState>(
            listener: (context, state) {
              if (state is RateSuccess) {
                _showDialog(state.successmsg);
                _showUserRateCubit.showRates(widget.userModel.id);
              } else if (state is RateFail) {
                Navigator.of(context).pop(); // Close the loading dialog
                _showDialog(state.errmsg);
              }
            },
            builder: (context, state) {
              return CustomContainar(
                child: Column(
                  children: [
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (r) {
                        setState(() {
                          rating = r;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      myController: commentController,
                      hintText: "Enter comment",
                      labelText: "Comment",
                      icon: const Icon(Icons.comment, color: Colors.white),
                      validator: (p0) => p0 == null ? 'Enter comment' : null,
                      focusNode: cF,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 10),
                    CustomMaterialButton(
                      text: 'Confirm',
                      onPressed: () {
                        BlocProvider.of<RateCubit>(context).rate(
                          widget.userModel.id,
                          '$rating',
                          commentController.text,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildError(String errorMsg) {
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
          errorMsg,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 146, 100, 239),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
