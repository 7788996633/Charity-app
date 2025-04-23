import 'package:baader/data/cubits/add_suggestion_cubit/add_suggestion_cubit.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_material_button.dart';
import 'package:baader/presentaion/widgets/custom_scaffold.dart';
import 'package:baader/presentaion/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSuggestionScreen extends StatefulWidget {
  const AddSuggestionScreen({super.key});

  @override
  State<AddSuggestionScreen> createState() => _AddSuggestionScreenState();
}

class _AddSuggestionScreenState extends State<AddSuggestionScreen> {
  TextEditingController suggController = TextEditingController();
  FocusNode suggFocusNode = FocusNode();
  String? suggValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your suggestion';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddSuggestionCubit, AddSuggestionState>(
      listener: (context, state) {
        if (state is AddSuggestionSuccess) {
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
        } else if (state is AddSuggestionFail) {
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
        }
      },
      builder: (context, state) {
        return CustomScaffold(
          appBarTitle: "Add a Suggestion",
          appBarActions: const Text(""),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "We are happy to know what is going in your mind.",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  CustomContainar(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "please write any suggestion may help us to improve our services.",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        CustomTextField(
                            myController: suggController,
                            hintText: "Enter your suggestion here",
                            labelText: "suggestion",
                            icon: const Icon(
                              Icons.comment,
                              color: Colors.white,
                            ),
                            validator: suggValidator,
                            focusNode: suggFocusNode,
                            textInputAction: TextInputAction.done),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        CustomMaterialButton(
                          text: "Submit",
                          onPressed: () {
                            BlocProvider.of<AddSuggestionCubit>(context)
                                .addSugg(suggController.text);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
