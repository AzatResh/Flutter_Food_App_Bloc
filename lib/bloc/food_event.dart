part of './food_bloc.dart';

abstract class FoodEvent extends Equatable{}

class FoodInitEvent extends FoodEvent{

  @override
  List<Object?> get props => [];
}

class FoodFetchEvent extends FoodEvent{
  
  @override
  List<Object?> get props => [];
}