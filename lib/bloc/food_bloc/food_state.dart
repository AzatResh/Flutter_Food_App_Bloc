part of 'food_bloc.dart';

class FoodState extends Equatable{
  
  final String currentCategory;
  final List<Food> foods;
  final bool isLoading;

  FoodState({
    this.foods = const [],
    this.currentCategory = '',
    this.isLoading = true
  });

  FoodState copyWith({
    String? currentCategory,
    List<Food>? foods,
    bool? isLoading = true,
  }){
    return FoodState(
      currentCategory: currentCategory?? this.currentCategory,
      foods: foods?? this.foods,
      isLoading: isLoading?? this.isLoading
    );
  }
  @override
  List<Object?> get props => [foods, currentCategory, isLoading];
}