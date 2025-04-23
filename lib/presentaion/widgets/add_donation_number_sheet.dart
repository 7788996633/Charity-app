// ignore_for_file: avoid_print

import 'package:baader/data/cubits/add_donation_number_cubit/add_donation_number_cubit.dart';
import 'package:baader/data/cubits/donation_numbers_cubit/donation_numbers_cubit.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_material_button.dart';
import 'package:baader/presentaion/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDonationNumberSheet extends StatefulWidget {
  const AddDonationNumberSheet({super.key});

  @override
  AddDonationNumberSheetState createState() => AddDonationNumberSheetState();
}

class AddDonationNumberSheetState extends State<AddDonationNumberSheet> {
  final _formKey = GlobalKey<FormState>();

  final _numberController = TextEditingController();
  FocusNode numberFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddDonationNumberCubit, AddDonationNumberState>(
      listener: (context, state) {
        if (state is AddDonationNumberSuccess) {
          // إغلاق الشيت
          Navigator.of(context).pop();

          // عرض رسالة نجاح
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

          // تحديث واجهة الأحداث
          BlocProvider.of<DonationNumbersCubit>(context).getDonationNumbers();
        } else if (state is AddDonationNumberFail) {
          // إغلاق الشيت
          Navigator.of(context).pop();

          // عرض رسالة خطأ
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 146, 100, 239),
              content: Text(
                state.errnsg,
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
        return CustomContainar(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(
                    focusNode: numberFocusNode,
                    textInputAction: TextInputAction.next,
                    hintText: "Enter donation number",
                    labelText: 'Number',
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    myController: _numberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomMaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<AddDonationNumberCubit>(context)
                            .addDonationNumber(_numberController.text);
                      }
                    },
                    text: 'Submit',
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
