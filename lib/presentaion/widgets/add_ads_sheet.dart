// ignore_for_file: avoid_print

import 'dart:io';
import 'package:baader/data/cubits/add_ads_cubit/add_ads_cubit.dart';
import 'package:baader/data/cubits/show_ads_cubit/show_ads_cubit.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_material_button.dart';
import 'package:baader/presentaion/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddAdsSheet extends StatefulWidget {
  const AddAdsSheet({super.key});

  @override
  AddArticleSheetState createState() => AddArticleSheetState();
}

class AddArticleSheetState extends State<AddAdsSheet> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  final _nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddAdsCubit, AddAdsState>(
      listener: (context, state) {
        if (state is AddAdsSuccess) {
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
          BlocProvider.of<ShowAdsCubit>(context).showAds();
        } else if (state is AddAdsFail) {
          // إغلاق الشيت
          Navigator.of(context).pop();

          // عرض رسالة خطأ
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
        return CustomContainar(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(
                    focusNode: nameFocusNode,
                    textInputAction: TextInputAction.next,
                    hintText: "Enter Ads name",
                    labelText: 'Name',
                    icon: const Icon(
                      Icons.title,
                      color: Colors.white,
                    ),
                    myController: _nameController,
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
                  const SizedBox(height: 20),
                  _selectedImage != null
                      ? Image.file(_selectedImage!, height: 150)
                      : const Text('No image selected'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Pick Image'),
                  ),
                  const SizedBox(height: 20),
                  CustomMaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _selectedImage != null) {
                        BlocProvider.of<AddAdsCubit>(context)
                            .addAds(_nameController.text, _selectedImage!);
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
