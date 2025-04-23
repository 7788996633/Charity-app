// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // استيراد الحزمة اللازمة
import '../../data/models/coursemodel.dart';
import 'custom_list_tile.dart';

class CourseItem extends StatelessWidget {
  const CourseItem({super.key, required this.courseModel});
  final CourseModel courseModel;

  Future<void> _copyToClipboard(BuildContext context) async {
    final String url = courseModel.url;

    try {
      // نسخ الرابط إلى الحافظة
      await Clipboard.setData(
        ClipboardData(text: url),
      );

      // إظهار رسالة تأكيد للمستخدم
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Link copied to clipboard!'),
        ),
      );
    } catch (e) {
      // التعامل مع أي أخطاء تحدث أثناء نسخ الرابط
      print('Error copying URL to clipboard: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to copy link to clipboard.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _copyToClipboard(context),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 31, 25, 107),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.network(
              courseModel.image,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.fill,
            ),
            CustomListTile(
              maxlines: 1,
              icon: const Icon(
                Icons.title,
                color: Colors.white,
                size: 25,
              ),
              title: '${courseModel.name} ',
            ),
            CustomListTile(
              maxlines: 2,
              icon: const Icon(
                Icons.description,
                color: Colors.white,
                size: 25,
              ),
              title: '${courseModel.description} ',
            ),
            CustomListTile(
              maxlines: 1,
              icon: const Icon(
                Icons.discount,
                color: Colors.white,
                size: 25,
              ),
              title: '${courseModel.discount}% ',
            ),
          ],
        ),
      ),
    );
  }
}
