import 'package:food_app/model/foodDetails.dart';

class FoodDetailResponse {
  final FoodDetail foodDetail;
  final bool hasError;
  final String error;

  FoodDetailResponse(this.foodDetail, this.hasError, this.error);

  FoodDetailResponse.fromJson(dynamic json)
      : foodDetail = FoodDetail.fromJson(json["meals"][0]),
        hasError = false,
        error = "";

  FoodDetailResponse.withError(String errorValue)
      : foodDetail = FoodDetail.empty,
        hasError = true,
        error = errorValue;
}