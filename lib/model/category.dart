import 'package:equatable/equatable.dart';

class FoodCategory extends Equatable {
  final String id;
  final String title;
  final String description;
  final String poster;

  const FoodCategory(this.id,  this.title, this.description, this.poster);

  FoodCategory.fromJson(Map<String, dynamic> json)
      : id = json["idCategory"],
        title = json["strCategory"] ?? "",
        description = json["strCategoryDescription"] ?? "",
        poster = json["strCategoryThumb"] ?? "";

  @override
  List<Object> get props =>
      [id, title, description, poster];
}