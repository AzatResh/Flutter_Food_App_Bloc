part of './food_bloc.dart';

class FoodState extends Equatable{

  final List items;
  final bool isLoading;

  const FoodState({
    this.items = const [],
    this.isLoading = true
  });
  
  FoodState copyWith({
    List? items,
    bool isLoading = true
    }){
      return FoodState(
          items: items?? this.items,
          isLoading: isLoading
      );
    }

  @override
  List<Object?> get props => [];
}