part of 'food_details_bloc.dart';

abstract class FoodDetailsEvent extends Equatable{}

class FoodDetailsGetFoodEvent extends FoodDetailsEvent{
  final String id;

  FoodDetailsGetFoodEvent({required this.id});

  @override
  List<Object?> get props => [];
}