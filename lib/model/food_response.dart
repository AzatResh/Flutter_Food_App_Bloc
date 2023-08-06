import 'package:food_app/model/food.dart';

class FoodResponse {
  final List<Food> foods;
  final bool hasError;
  final String error;

  FoodResponse(this.foods, this.hasError, this.error);

  FoodResponse.fromJson(Map<String, dynamic> json)
      : foods = (json["meals"] as List)
            .map((i) => Food.fromJson(i))
            .toList(),
        hasError = false,
        error = "";

  FoodResponse.withError(String errorValue)
      : foods = [],
        hasError = true,
        error = errorValue;
}