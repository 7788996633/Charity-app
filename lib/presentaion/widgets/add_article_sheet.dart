// ignore_for_file: avoid_print

import 'dart:io';
import 'package:baader/data/cubits/add_article_cubit/add_article_cubit.dart';
import 'package:baader/data/cubits/articles_cubit/articles_cubit.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_material_button.dart';
import 'package:baader/presentaion/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddArticleSheet extends StatefulWidget {
  const AddArticleSheet({super.key});

  @override
  AddArticleSheetState createState() => AddArticleSheetState();
}

class AddArticleSheetState extends State<AddArticleSheet> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  String selectedItem = 'Medical';
  List<String> items = ['Medical', 'Family', 'Business', 'Social'];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddArticleCubit, AddArticleState>(
      listener: (context, state) {
        if (state is AddArticleSuccess) {
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
          BlocProvider.of<ArticlesCubit>(context).getAllArticles();
        } else if (state is AddArticleFail) {
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
                    hintText: "Enter Article name",
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
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      dropdownColor: const Color.fromARGB(255, 31, 25, 107),
                      value: selectedItem,
                      icon: const Icon(
                        Icons.category,
                        color: Colors.white,
                      ),
                      items: items.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedItem = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    focusNode: descFocusNode,
                    textInputAction: TextInputAction.done,
                    hintText: "Enter Article description",
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
                        BlocProvider.of<AddArticleCubit>(context).addArticle(
                            _nameController.text,
                            _descriptionController.text,
                            selectedItem,
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
