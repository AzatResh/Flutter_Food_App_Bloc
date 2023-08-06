import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/model/category_response.dart';
import 'package:food_app/repositories/food_repository.dart';
import 'package:food_app/model/category.dart';

part 'categories_state.dart';
part 'categories_event.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState>{
  CategoriesBloc({required this.foodRepository}): super(CategoriesState()){
    on<CategoriesFetchEvent>(_onFetched);
  }

  final FoodRepository foodRepository;

  _onFetched(CategoriesFetchEvent event, Emitter<CategoriesState> emit) async{
    CategoryResponse categoryResponse = await foodRepository.getCategories();

    if(!categoryResponse.hasError){
      emit(state.copyWith(
        categories: categoryResponse.categories,
        isLoading: false
      ));
    }
    else{
      throw Exception(categoryResponse.error);
    }
  }
}