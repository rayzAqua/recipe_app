import 'dart:convert';
import 'package:pratical_flutter/models/filter_model.dart';
import 'package:http/http.dart' as http;

class LocationApi {
  static Future<LocationModel> fetchLocationDataApi() async {
    try {
      final url = Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/list.php?a=list',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final location = data['meals'];
        return LocationModel.fromJson(location);
      } else {
        throw Exception('Lỗi HTTP: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
