part of 'food_bloc.dart';

abstract class FoodEvent extends Equatable{}

class FoodGetFoodEvent extends FoodEvent{
  final String category;

  FoodGetFoodEvent({required this.category});

  @override
  List<Object?> get props => [];
}