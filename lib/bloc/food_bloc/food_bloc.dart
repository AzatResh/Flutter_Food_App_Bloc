import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:food_app/model/food_response.dart';
import 'package:food_app/repositories/food_repository.dart';
import 'package:food_app/model/food.dart';

part 'food_state.dart';
part 'food_event.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState>{
  FoodBloc({required this.foodRepository}) : super(FoodStateInit()){
    on<FoodGetFoodEvent>(_onGetFood);
  }

  final FoodRepository foodRepository;

  _onGetFood(FoodGetFoodEvent event, Emitter<FoodState> emit) async {
    emit(FoodLoadingState());
    FoodResponse foodResponse = await foodRepository.getFoodsByCategory(event.category);

    if(!foodResponse.hasError){
      emit(FoodStateLoaded(foods: foodResponse.foods));
    }
    else{
      throw Exception(foodResponse.error);
    }
  }
}