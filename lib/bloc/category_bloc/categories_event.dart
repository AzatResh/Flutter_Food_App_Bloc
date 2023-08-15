part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable{}

class CategoriesInitEvent extends CategoriesEvent{

  @override
  List<Object?> get props => [];
}

class CategoriesFetchEvent extends CategoriesEvent{
  @override
  List<Object?> get props => [];
}
class CategoryChooseEvent extends CategoriesEvent{
  
  final String category;
  CategoryChooseEvent({required this.category});

  @override
  List<Object?> get props => [];
}