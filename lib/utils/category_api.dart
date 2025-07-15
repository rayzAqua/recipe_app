import 'dart:convert';
import 'package:pratical_flutter/models/filter_model.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  static Future<CategoryModel> fetchCategoryDataApi() async {
    try {
      final url = Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/list.php?c=list',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final category = data['meals'];
        return CategoryModel.fromJson(category);
      } else {
        throw Exception('Lỗi HTTP: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
