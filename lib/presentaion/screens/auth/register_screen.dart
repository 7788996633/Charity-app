import 'dart:io';

import 'package:baader/data/cubits/articles_cubit/articles_cubit.dart';
import 'package:baader/data/cubits/donation_numbers_cubit/donation_numbers_cubit.dart';
import 'package:baader/data/cubits/events_cubit/events_cubit.dart';
import 'package:baader/data/cubits/register_cubit/register_cubit.dart';
import 'package:baader/data/cubits/user_cubit/user_cubit.dart';
import 'package:baader/data/cubits/user_role_cubit/user_role_cubit.dart';
import 'package:baader/presentaion/screens/home/home.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:baader/presentaion/widgets/custom_material_button.dart';
import 'package:baader/presentaion/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constants.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  GlobalKey<FormState> myKey = GlobalKey<FormState>();
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  String? firstNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  String? lastNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

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

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
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
        } else if (state is RegisterFail) {
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
        } else if (state is RegisterLoading) {
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    CustomContainar(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Text(
                              'Create a new account',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            CustomTextField(
                              icon: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              myController: firstNameController,
                              hintText: "Enter Your First Name",
                              labelText: "First Name",
                              validator: firstNameValidator,
                              focusNode: firstNameFocusNode,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(lastNameFocusNode);
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            CustomTextField(
                              icon: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              myController: lastNameController,
                              hintText: "Enter Your Last Name",
                              labelText: "Last Name",
                              validator: lastNameValidator,
                              focusNode: lastNameFocusNode,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(emailFocusNode);
                              },
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
                              labelText: "Email",
                              validator: emailValidator,
                              focusNode: emailFocusNode,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(passwordFocusNode);
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            CustomTextField(
                              icon: const Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              myController: passwordController,
                              hintText: "Enter Your Password",
                              labelText: "Password",
                              validator: passwordValidator,
                              focusNode: passwordFocusNode,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(phoneFocusNode);
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            CustomTextField(
                              icon: const Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              myController: phoneController,
                              hintText: "Enter Your Phone Number",
                              labelText: "Phone",
                              validator: phoneValidator,
                              focusNode: phoneFocusNode,
                              textInputAction: TextInputAction.done,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            _selectedImage != null
                                ? Image.file(_selectedImage!,
                                    height: MediaQuery.of(context).size.height *
                                        0.2)
                                : const Text('No image selected'),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _pickImage,
                              child: const Text('Pick Image'),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            CustomMaterialButton(
                              text: "SignUp",
                              onPressed: () {
                                if (myKey.currentState?.validate() ??
                                    _selectedImage != null && false) {
                                  BlocProvider.of<RegisterCubit>(context)
                                      .register(
                                          firstNameController.text,
                                          lastNameController.text,
                                          emailController.text,
                                          passwordController.text,
                                          phoneController.text,
                                          _selectedImage!);
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
                                  "You have an account ? ",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Login",
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
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
