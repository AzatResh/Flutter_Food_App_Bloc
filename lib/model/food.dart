import 'package:equatable/equatable.dart';

class Food extends Equatable {
  final String id;
  final String title;
  final String poster;

  const Food(this.id,  this.title, this.poster);

  Food.fromJson(Map<String, dynamic> json)
      : id = json["idMeal"],
        title = json["strMeal"] ?? "",
        poster = json["strMealThumb"] ?? "";

  @override
  List<Object> get props =>
      [id, title, poster];
}