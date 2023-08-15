part of 'food_bloc.dart';

abstract class FoodEvent extends Equatable{}

class FoodGetFoodEvent extends FoodEvent{
  final String category;

  FoodGetFoodEvent({required this.category});

  @override
  List<Object?> get props => [category];
}

class SearchFoodEvent extends FoodEvent{
  final String name;
  final String category;

  SearchFoodEvent({required this.name, required this.category});

  @override
  List<Object?> get props => [name, category];
}