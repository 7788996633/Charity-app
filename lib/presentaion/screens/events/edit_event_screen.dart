import 'dart:io';

import 'package:baader/data/cubits/edit_event_cubit/edit_event_cubit.dart';
import 'package:baader/data/models/eventmodel.dart';
import 'package:baader/presentaion/widgets/custom_containar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/custom_scaffold.dart';
import '../../widgets/custom_text_field.dart';

class EditEventScreen extends StatefulWidget {
  final EventModel event;

  const EditEventScreen({super.key, required this.event});

  @override
  EditEventScreenState createState() => EditEventScreenState();
}

class EditEventScreenState extends State<EditEventScreen> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  final _formKey = GlobalKey<FormState>();

  FocusNode nameFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();
  FocusNode locationFocusNode = FocusNode();
  FocusNode startDateFocusNode = FocusNode();
  FocusNode endDateFocusNode = FocusNode();
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
    nameController = TextEditingController(text: widget.event.name);
    descriptionController =
        TextEditingController(text: widget.event.description);
    locationController = TextEditingController(text: widget.event.location);
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
      appBarTitle: 'Edit Event',
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
                          widget.event.image,
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
                    hintText: 'Event Name',
                    labelText: 'Enter Event Name',
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
                    hintText: 'Event Descreption',
                    labelText: 'Enter Event Descreption',
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
                    focusNode: locationFocusNode,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the location';
                      }
                      return null;
                    },
                    hintText: 'Event location',
                    labelText: 'Enter Event location',
                    myController: locationController,
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  BlocConsumer<EditEventCubit, EditEventState>(
                    listener: (context, state) {
                      if (state is EditEventSuccess) {
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
                      } else if (state is EditEventFail) {
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
                          BlocProvider.of<EditEventCubit>(context).editEvent(
                              widget.event.id,
                              nameController.text,
                              descriptionController.text,
                              locationController.text,
                              _selectedImage);
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
