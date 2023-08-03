part of 'categories_bloc.dart';

class CategoriesState extends Equatable{

  final List categories;
  final bool isLoading;

  const CategoriesState({
    this.categories = const [],
    this.isLoading = true
  });
  
  CategoriesState copyWith({
    List? categories,
    bool isLoading = true
    }){
      return CategoriesState(
          categories: categories?? this.categories,
          isLoading: isLoading
      );
    }

  @override
  List<Object?> get props => [];
}