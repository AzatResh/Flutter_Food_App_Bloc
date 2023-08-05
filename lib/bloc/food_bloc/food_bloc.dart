import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

part 'food_state.dart';
part 'food_event.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState>{
  FoodBloc() : super(FoodStateInit()){
    on<FoodGetFoodEvent>(_onGetFood);
  }

  _onGetFood(FoodGetFoodEvent event, Emitter<FoodState> emit) async {
    emit(FoodLoadingState());
    final url = Uri.parse('https://themealdb.com/api/json/v1/1/filter.php?c=${event.category}');
    final response = await http.get(url);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      final List foods = await data['meals'];

      emit(FoodStateLoaded(foods: foods));
    }
  }
}