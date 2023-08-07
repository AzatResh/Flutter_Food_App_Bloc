part of 'food_details_bloc.dart';

abstract class FoodDetailsState extends Equatable{}

class FoodDetailsStateInit extends FoodDetailsState{
  @override
  List<Object?> get props => [];
}

class FoodDetailsLoadingState extends FoodDetailsState{
  @override
  List<Object?> get props => [];
}

class FoodDetailsStateLoaded extends FoodDetailsState{

  final FoodDetail food;

  FoodDetailsStateLoaded({required this.food});

  @override
  List<Object?> get props => [food];
}