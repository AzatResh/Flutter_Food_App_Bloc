import 'package:equatable/equatable.dart';

class FoodDetail extends Equatable {
  final String id;
  final String title;
  final String area;
  final String instruction;
  final String tags;
  final String poster;

  const FoodDetail(this.id,  this.title, this.area, this.instruction, this.tags, this.poster);

  FoodDetail.fromJson(Map<String, dynamic> json)
      : id = json["idMeal"],
        title = json["strMeal"] ?? "",
        area = json["strArea"] ?? "",
        instruction = json["strInstructions"] ?? "",
        tags = json["strTags"] ?? "",
        poster = json["strMealThumb"] ?? "";

  @override
  List<Object> get props =>
      [id, title, poster];

  static const empty = FoodDetail("", "", "", "", "", "");
}