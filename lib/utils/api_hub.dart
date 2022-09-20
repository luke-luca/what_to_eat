import 'package:dio/dio.dart';
import 'package:what_to_eat/models/models.dart';

class ApiHub {
  ApiHub._internal();

  factory ApiHub() => _instance;

  static final ApiHub _instance = ApiHub._internal();
  static const _apiUrl = 'https://www.themealdb.com/api/json/v1/1/';
  static const _apiKey = '1';
  final Dio dio = Dio();

  Future<Meal> fetchRandomMeal() async {
    RequestOptions options = RequestOptions(
      path: '/random.php',
      baseUrl: _apiUrl,
      headers: {'apikey': _apiKey},
      method: 'GET',
    );
    Response respone = await dio.fetch(options);
    return (respone.data['meals'] as List<dynamic>)
        .map((e) => Meal.fromJson(e))
        .toList()
        .first;
  }
}
