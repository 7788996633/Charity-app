import 'package:baader/data/cubits/help_request_cubit/help_request_cubit.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:baader/presentaion/widgets/custom_material_button.dart';
import 'package:baader/presentaion/widgets/custom_scaffold.dart';
import 'package:baader/presentaion/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitHelpRequestScreen extends StatefulWidget {
  const SubmitHelpRequestScreen({super.key});

  @override
  State<SubmitHelpRequestScreen> createState() =>
      _SubmitHelpRequestScreenState();
}

class _SubmitHelpRequestScreenState extends State<SubmitHelpRequestScreen> {
  TextEditingController descController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController neighController = TextEditingController();

  FocusNode descFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode streetFocusNode = FocusNode();
  FocusNode neighFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  String? desktopTextSelectionControls(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HelpRequestCubit, HelpRequestState>(
      listener: (context, state) {
        if (state is HelpRequestSuccess) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 146, 100, 239),
              content: Text(
                state.succesmsg,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else if (state is HelpRequestFail) {
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
        } else {
          const CustomLoadingIndicator();
        }
      },
      builder: (context, state) {
        return CustomScaffold(
          appBarTitle: "Help request",
          appBarActions: const Text(""),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Do you need any help ?",
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
                            "please write the situation and the address .",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          CustomTextField(
                              myController: descController,
                              hintText: "Enter your situation here",
                              labelText: "situation",
                              icon: const Icon(
                                Icons.comment,
                                color: Colors.white,
                              ),
                              validator: desktopTextSelectionControls,
                              focusNode: descFocusNode,
                              textInputAction: TextInputAction.next),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          CustomTextField(
                              myController: cityController,
                              hintText: "Enter your city here",
                              labelText: "city",
                              icon: const Icon(
                                Icons.location_city,
                                color: Colors.white,
                              ),
                              validator: desktopTextSelectionControls,
                              focusNode: cityFocusNode,
                              textInputAction: TextInputAction.next),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          CustomTextField(
                              myController: streetController,
                              hintText: "Enter your street here",
                              labelText: "street",
                              icon: const Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              validator: desktopTextSelectionControls,
                              focusNode: streetFocusNode,
                              textInputAction: TextInputAction.next),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          CustomTextField(
                              myController: neighController,
                              hintText: "Enter your neighborhood here",
                              labelText: "neighborhood",
                              icon: const Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              validator: desktopTextSelectionControls,
                              focusNode: neighFocusNode,
                              textInputAction: TextInputAction.done),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          CustomMaterialButton(
                            text: "Submit",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<HelpRequestCubit>(context)
                                    .helpRequest(
                                        descController.text,
                                        cityController.text,
                                        streetController.text,
                                        neighController.text);
                              }
                            },
                          ),
                        ],
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
