// ignore_for_file: avoid_print

import 'package:baader/data/helper/api.dart';
import 'package:http/http.dart' as http;

class GalleryServices {
  Future<List> showGallery() async {
    var data = await Api().gett(
      "api/show_gallery",
    );

    try {
      print(data);
      return data['success'];
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> addEventToGallery(String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var body = ({
      'name': '444',
      'type': 'humanitarian',
      'description': 'كلام كثير جدا هههه',
      'target_category': 'poor',
      'start_date': '2023-1-2',
      'end_date': '2023-2-1',
      'location': 'al-mazzah'
    });
    var data = await Api().postt('api/addEve_to_Galleries', headers, body);
    print(data);
  }

  Future<void> deleteEventFromGallery(String eventId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
      'DELETE',
      Uri.parse('${Api().myUrl}/api/deleteEve_to_Galleries/$eventId'),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
