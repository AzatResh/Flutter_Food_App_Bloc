import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'categories_state.dart';
part 'categories_event.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState>{
  CategoriesBloc(): super(CategoriesState()){
    on<CategoriesFetchEvent>(_onFetched);
  }

  _onFetched(CategoriesFetchEvent event, Emitter<CategoriesState> emit) async{
    final url = Uri.parse('https://themealdb.com/api/json/v1/1/categories.php');
    final response = await http.get(url);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      final List categoriesItems = await data['categories'];

      emit(state.copyWith(
        categories: categoriesItems,
        isLoading: false
      ));
    }
  }

}