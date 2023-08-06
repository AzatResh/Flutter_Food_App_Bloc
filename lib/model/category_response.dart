import 'package:food_app/model/category.dart';

class CategoryResponse {
  final List<FoodCategory> categories;
  final bool hasError;
  final String error;

  CategoryResponse(this.categories, this.hasError, this.error);

  CategoryResponse.fromJson(Map<String, dynamic> json)
      : categories = (json["categories"] as List)
            .map((i) => FoodCategory.fromJson(i))
            .toList(),
        hasError = false,
        error = "";

  CategoryResponse.withError(String errorValue)
      : categories = [],
        hasError = true,
        error = errorValue;
}