import 'dart:io';

import 'package:baader/data/models/coursemodel.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/cubits/edit_course_cubit/edit_course_cubit.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/custom_text_field.dart';

class EditCourseScreen extends StatefulWidget {
  final CourseModel course;

  const EditCourseScreen({super.key, required this.course});

  @override
  EditCourseScreenState createState() => EditCourseScreenState();
}

class EditCourseScreenState extends State<EditCourseScreen> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController discountController;
  late TextEditingController urlController;

  final _formKey = GlobalKey<FormState>();

  FocusNode nameFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();
  FocusNode discountFocusNode = FocusNode();
  FocusNode urlFocusNode = FocusNode();

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

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.course.name);
    descriptionController =
        TextEditingController(text: widget.course.description);
    discountController = TextEditingController(
      text: widget.course.discount.toString(),
    );
    urlController = TextEditingController(text: widget.course.url);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'Edit Course',
      appBarActions: const Text(''),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: CustomContainar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _selectedImage != null
                      ? Image.file(_selectedImage!,
                          height: MediaQuery.of(context).size.height * 0.3)
                      : Image.network(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.3,
                          widget.course.image,
                          fit: BoxFit.fill,
                        ),
                  IconButton(
                    color: Colors.black,
                    onPressed: _pickImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  CustomTextField(
                    focusNode: nameFocusNode,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name';
                      }
                      return null;
                    },
                    hintText: 'Course Name',
                    labelText: 'Enter Course Name',
                    myController: nameController,
                    icon: const Icon(
                      Icons.title,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CustomTextField(
                    focusNode: descFocusNode,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the description';
                      }
                      return null;
                    },
                    hintText: 'Course Descreption',
                    labelText: 'Enter Course Descreption',
                    myController: descriptionController,
                    icon: const Icon(
                      Icons.description,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CustomTextField(
                    focusNode: discountFocusNode,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the discount';
                      }
                      return null;
                    },
                    hintText: 'Course discount',
                    labelText: 'Enter Course discount',
                    myController: discountController,
                    icon: const Icon(
                      Icons.discount,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CustomTextField(
                    focusNode: urlFocusNode,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the url';
                      }
                      return null;
                    },
                    hintText: 'Course url',
                    labelText: 'Enter Course url',
                    myController: urlController,
                    icon: const Icon(
                      Icons.http,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  BlocConsumer<EditCourseCubit, EditCourseState>(
                    listener: (context, state) {
                      if (state is EditCourseSuccess) {
                        // إغلاق الشيت
                        Navigator.of(context).pop();

                        // عرض رسالة نجاح
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor:
                                const Color.fromARGB(255, 146, 100, 239),
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
                      } else if (state is EditCourseFail) {
                        Navigator.of(context).pop();

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor:
                                const Color.fromARGB(255, 146, 100, 239),
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
                      return ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<EditCourseCubit>(context).editCourse(
                            widget.course.id,
                            nameController.text,
                            urlController.text,
                            descriptionController.text,
                            discountController.text,
                            _selectedImage,
                          );
                        },
                        child: const Text('Save Changes'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
