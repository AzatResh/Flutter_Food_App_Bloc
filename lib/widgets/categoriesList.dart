import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/category_bloc/categories_bloc.dart';

class CategoriesList extends StatefulWidget{
  const CategoriesList({super.key});
  
   @override
  State<CategoriesList> createState() => CategoriesListState();
}
class CategoriesListState extends State<CategoriesList>{

  int _selectedCategoryIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => CategoriesBloc()..add(CategoriesFetchEvent()),
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          final items = context.select((CategoriesBloc bloc) => bloc.state.categories);
          return ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 5,),
              Wrap(
                spacing: 4.0,
                runSpacing: 0.0,
                children: List<Widget>.generate(
                  items.length,
                  (int index) {
                    return ChoiceChip(
                      selected: index == _selectedCategoryIndex,
                      label: Text(items[index]['strCategory']),
                      onSelected: (selected) {
                        if(selected){
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        }
                      },
                    );
                  }
                ).toList(),
              ),
            ],
          ); 
        },
      )
    );
  }
}