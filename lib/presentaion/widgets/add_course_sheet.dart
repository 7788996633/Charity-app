// ignore_for_file: avoid_print

import 'dart:io';

import 'package:baader/data/cubits/add_course_cubit/add_course_cubit.dart';
import 'package:baader/data/cubits/courses_cubit/courses_cubit.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_material_button.dart';
import 'package:baader/presentaion/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddCourseSheet extends StatefulWidget {
  const AddCourseSheet({super.key});

  @override
  AddCourseSheetState createState() => AddCourseSheetState();
}

class AddCourseSheetState extends State<AddCourseSheet> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  final _nameController = TextEditingController();
  final _urlController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _discountController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode typeFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();
  FocusNode startFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCourseCubit, AddCourseState>(
      listener: (context, state) {
        if (state is AddCourseSuccess) {
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
          BlocProvider.of<CoursesCubit>(context).showCourses();
        } else if (state is AddCourseFail) {
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
                    hintText: "Enter Course name",
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
                  CustomTextField(
                    focusNode: typeFocusNode,
                    textInputAction: TextInputAction.next,
                    hintText: "Enter Course url",
                    labelText: 'Url',
                    icon: const Icon(
                      Icons.category,
                      color: Colors.white,
                    ),
                    myController: _urlController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the url';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    focusNode: descFocusNode,
                    textInputAction: TextInputAction.next,
                    hintText: "Enter Course description",
                    labelText: 'Description',
                    icon: const Icon(
                      Icons.description,
                      color: Colors.white,
                    ),
                    myController: _descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    focusNode: startFocusNode,
                    textInputAction: TextInputAction.next,
                    hintText: "Enter Course discount",
                    labelText: 'Discount',
                    icon: const Icon(
                      Icons.discount,
                      color: Colors.white,
                    ),
                    myController: _discountController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the discount';
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
                        BlocProvider.of<AddCourseCubit>(context).addCourse(
                            _nameController.text,
                            _urlController.text,
                            _descriptionController.text,
                            _discountController.text,
                            _selectedImage!);
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
