import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:food_app/model/foodDetails_response.dart';
import 'package:food_app/repositories/food_repository.dart';
import 'package:food_app/model/foodDetails.dart';

part 'food_details_state.dart';
part 'food_details_event.dart';

class FoodDetailsBloc extends Bloc<FoodDetailsEvent, FoodDetailsState>{
  FoodDetailsBloc({required this.foodRepository}) : super(FoodDetailsStateInit()){
    on<FoodDetailsGetFoodEvent>(_onGetFood);
  }

  final FoodRepository foodRepository;

  _onGetFood(FoodDetailsGetFoodEvent event, Emitter<FoodDetailsState> emit) async {
    emit(FoodDetailsLoadingState());
    FoodDetailResponse foodResponse = await foodRepository.getFoodByID(event.id);

    if(!foodResponse.hasError){
      emit(FoodDetailsStateLoaded(food: foodResponse.foodDetail));
    }
    else{
      throw Exception(foodResponse.error);
    }
  }
}