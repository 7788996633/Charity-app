// // ignore_for_file: avoid_print

// import 'dart:io';
// import 'package:baderrrrr/data/cubits/edit_event_cubit/edit_event_cubit.dart';
// import 'package:baderrrrr/data/models/eventmodel.dart';
// import 'package:baderrrrr/presentaion/widgets/custom_containar.dart';
// import 'package:baderrrrr/presentaion/widgets/custom_text_field.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../data/cubits/events_cubit/events_cubit.dart';

// class EditEventSheet extends StatefulWidget {
//   const EditEventSheet({super.key, required this.event});
//   final EventModel event;

//   @override
//   AddEventSheetState createState() => AddEventSheetState();
// }

// class AddEventSheetState extends State<EditEventSheet> {
//   final _formKey = GlobalKey<FormState>();
//   final ImagePicker _picker = ImagePicker();
//   File? _selectedImage;

//   late TextEditingController nameController;
//   late TextEditingController descriptionController;
//   late TextEditingController locationController;
//   late TextEditingController startDateController;
//   late TextEditingController endDateController;
//   FocusNode nameFocusNode = FocusNode();
//   FocusNode descFocusNode = FocusNode();
//   FocusNode locationFocusNode = FocusNode();

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     nameController = TextEditingController(text: widget.event.name);
//     descriptionController =
//         TextEditingController(text: widget.event.description);
//     locationController = TextEditingController(text: widget.event.location);
//     startDateController =
//         TextEditingController(text: widget.event.startDate.toString());

//     endDateController =
//         TextEditingController(text: widget.event.endDate.toString());
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     descriptionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<EditEventCubit, EditEventState>(
//       listener: (context, state) {
//         if (state is EditEventSuccess) {
//           // إغلاق الشيت
//           Navigator.of(context).pop();

//           // عرض رسالة نجاح
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               backgroundColor: const Color.fromARGB(255, 146, 100, 239),
//               content: Text(
//                 state.successmsg,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           );

//           // تحديث واجهة الأحداث
//           BlocProvider.of<EventsCubit>(context).getAllEvents();
//         } else if (state is EditEventFail) {
//           // إغلاق الشيت
//           Navigator.of(context).pop();

//           // عرض رسالة خطأ
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               backgroundColor: const Color.fromARGB(255, 146, 100, 239),
//               content: Text(
//                 state.errmsg,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         return CustomContainar(
//           child: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   _selectedImage != null
//                       ? Image.file(_selectedImage!,
//                           height: MediaQuery.of(context).size.height * 0.3)
//                       : Image.network(
//                           width: double.infinity,
//                           height: MediaQuery.of(context).size.height * 0.3,
//                           widget.event.image,
//                           fit: BoxFit.fill,
//                         ),
//                   IconButton(
//                     color: Colors.black,
//                     onPressed: _pickImage,
//                     icon: const Icon(
//                       Icons.add_a_photo,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                   ),
//                   CustomTextField(
//                     focusNode: nameFocusNode,
//                     textInputAction: TextInputAction.next,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter the name';
//                       }
//                       return null;
//                     },
//                     hintText: 'Event Name',
//                     labelText: 'Enter Event Name',
//                     myController: nameController,
//                     icon: const Icon(
//                       Icons.title,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.02,
//                   ),
//                   CustomTextField(
//                     focusNode: descFocusNode,
//                     textInputAction: TextInputAction.done,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter the description';
//                       }
//                       return null;
//                     },
//                     hintText: 'Event Descreption',
//                     labelText: 'Enter Event Descreption',
//                     myController: descriptionController,
//                     icon: const Icon(
//                       Icons.description,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.02,
//                   ),
//                   CustomTextField(
//                     focusNode: locationFocusNode,
//                     textInputAction: TextInputAction.next,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter the location';
//                       }
//                       return null;
//                     },
//                     hintText: 'Event location',
//                     labelText: 'Enter Event location',
//                     myController: locationController,
//                     icon: const Icon(
//                       Icons.location_on,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.02,
//                   ),
//                   BlocConsumer<EditEventCubit, EditEventState>(
//                     listener: (context, state) {
//                       if (state is EditEventSuccess) {
//                         // إغلاق الشيت
//                         Navigator.of(context).pop();

//                         // عرض رسالة نجاح
//                         showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             backgroundColor:
//                                 const Color.fromARGB(255, 146, 100, 239),
//                             content: Text(
//                               state.successmsg,
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         );
//                       } else if (state is EditEventFail) {
//                         Navigator.of(context).pop();

//                         showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             backgroundColor:
//                                 const Color.fromARGB(255, 146, 100, 239),
//                             content: Text(
//                               state.errmsg,
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                     builder: (context, state) {
//                       return ElevatedButton(
//                         onPressed: () {
//                           BlocProvider.of<EditEventCubit>(context).editEvent(
//                               widget.event.id,
//                               nameController.text,
//                               descriptionController.text,
//                               locationController.text,
//                               _selectedImage);
//                         },
//                         child: const Text('Save Changes'),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
