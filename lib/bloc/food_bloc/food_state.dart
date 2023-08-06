part of 'food_bloc.dart';

abstract class FoodState extends Equatable{}

class FoodStateInit extends FoodState{
  @override
  List<Object?> get props => [];
}

class FoodLoadingState extends FoodState{
  @override
  List<Object?> get props => [];
}

class FoodStateLoaded extends FoodState{

  final List<Food> foods;

  FoodStateLoaded({required this.foods});

  @override
  List<Object?> get props => [foods];
}