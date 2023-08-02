import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'food_state.dart';
part 'food_event.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState>{
  FoodBloc(): super(FoodState()){
    on<FoodFetchEvent>(_onFetched);
  }

  _onFetched(FoodFetchEvent event, Emitter<FoodState> emit) async{
    await Future.delayed(const Duration(seconds: 5));

    final url = Uri.parse('https://themealdb.com/api/json/v1/1/categories.php');
    final response = await http.get(url);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      final List foodItems = await data['categories'];

      emit(state.copyWith(
        items: foodItems,
        isLoading: false
      ));
    }
  }

}