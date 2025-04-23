// ignore_for_file: avoid_print

import 'dart:io';
import 'package:baader/data/cubits/add_events_cubit/add_events_cubit.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:baader/presentaion/widgets/custom_material_button.dart';
import 'package:baader/presentaion/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/cubits/events_cubit/events_cubit.dart';

class AddEventSheet extends StatefulWidget {
  const AddEventSheet({super.key});

  @override
  AddEventSheetState createState() => AddEventSheetState();
}

class AddEventSheetState extends State<AddEventSheet> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _locationController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();
  FocusNode startFocusNode = FocusNode();
  FocusNode endFocusNode = FocusNode();
  FocusNode locationFocusNode = FocusNode();

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
    return BlocConsumer<AddEventsCubit, AddEventsState>(
      listener: (context, state) {
        if (state is AddEventsSuccess) {
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
          BlocProvider.of<EventsCubit>(context).getAllEvents();
        } else if (state is AddEventsFail) {
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
                    hintText: "Enter event name",
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
                    focusNode: descFocusNode,
                    textInputAction: TextInputAction.next,
                    hintText: "Enter event description",
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
                    hintText: "Enter event start date",
                    labelText: 'Start Date',
                    icon: const Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    myController: _startDateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the start date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    focusNode: endFocusNode,
                    textInputAction: TextInputAction.next,
                    hintText: "Enter event end date",
                    icon: const Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    myController: _endDateController,
                    labelText: 'End Date',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the end date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    focusNode: locationFocusNode,
                    textInputAction: TextInputAction.done,
                    hintText: "Enter event location",
                    labelText: 'Location',
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    myController: _locationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the location';
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
                        BlocProvider.of<AddEventsCubit>(context).addEvent(
                            _nameController.text,
                            _descriptionController.text,
                            _startDateController.text,
                            _endDateController.text,
                            _locationController.text,
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
