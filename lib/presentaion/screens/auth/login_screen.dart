import 'package:baader/data/cubits/donation_numbers_cubit/donation_numbers_cubit.dart';
import 'package:baader/data/cubits/login_cubit/login_cubit.dart';
import 'package:baader/data/cubits/user_cubit/user_cubit.dart';
import 'package:baader/data/cubits/user_role_cubit/user_role_cubit.dart';
import 'package:baader/presentaion/screens/home/home.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:baader/presentaion/widgets/custom_material_button.dart';
import 'package:baader/presentaion/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../data/cubits/articles_cubit/articles_cubit.dart';
import '../../../data/cubits/events_cubit/events_cubit.dart';
import '../../widgets/custom_text_field.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String token = '';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  GlobalKey<FormState> myKey = GlobalKey<FormState>();

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          setState(() {
            myToken = state.token;
          });
          BlocProvider.of<UserCubit>(context).getUserInfo(UserRoleCubit());
          BlocProvider.of<ArticlesCubit>(context).getAllArticles();

          BlocProvider.of<DonationNumbersCubit>(context).getDonationNumbers();
          BlocProvider.of<EventsCubit>(context).getAllEvents();

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
            (route) => false,
          );
        } else if (state is LoginFail) {
          Navigator.of(context).pop(); // Close the loading dialog
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
        } else if (state is LoginLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CustomLoadingIndicator(),
            ),
          );
        }
      },
      builder: (context, state) {
        return CustomScaffold(
          appBarTitle: "",
          appBarActions: const Text(""),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: myKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Baader',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    CustomContainar(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            CustomTextField(
                              icon: const Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              myController: emailController,
                              hintText: "Enter Your Email",
                              labelText: "email",
                              validator: emailValidator,
                              focusNode: emailFocusNode,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(passwordFocusNode);
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            CustomTextField(
                              icon: const Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              myController: passwordController,
                              hintText: "Enter Your Password",
                              labelText: "password",
                              validator: passwordValidator,
                              focusNode: passwordFocusNode,
                              textInputAction: TextInputAction.done,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            CustomMaterialButton(
                              text: "Login",
                              onPressed: () {
                                if (myKey.currentState?.validate() ?? false) {
                                  BlocProvider.of<LoginCubit>(context)
                                      .loginCubit(emailController.text,
                                          passwordController.text);
                                }
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
