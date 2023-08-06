import 'dart:convert';
import 'package:food_app/model/category_response.dart';
import 'package:food_app/model/food_response.dart';
import 'package:http/http.dart' as http;

class FoodRepository{

  static String mainUrl = 'https://themealdb.com/api/json/v1/1';

  String categoriesUrl = '$mainUrl/categories.php';
  String foodsByCategoryUrl = '$mainUrl/filter.php?c=';
  
  Future<CategoryResponse> getCategories() async{
    final url = Uri.parse(categoriesUrl);
    final response = await http.get(url);

    try{
      final data = jsonDecode(response.body);
      return CategoryResponse.fromJson(data);
    }
    catch(error, stacktrace){
      return CategoryResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }

  Future<FoodResponse> getFoodsByCategory(String category) async{
    final url = Uri.parse(foodsByCategoryUrl+category);
    final response = await http.get(url);

    try{
      final data = jsonDecode(response.body);
      return FoodResponse.fromJson(data);
    }
    catch(error, stacktrace){
      return FoodResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }
}