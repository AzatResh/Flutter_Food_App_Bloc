import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/food_bloc/food_bloc.dart';
import '../bloc/category_bloc/categories_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) => CategoriesBloc()..add(CategoriesFetchEvent())),
        BlocProvider(create:(context) => FoodBloc()..add(FoodGetFoodEvent(category: 'Seafood')))
      ], 
      child: const MaterialApp(home: MyHomePage())
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food App'),
        backgroundColor: Color.fromARGB(255, 201, 41, 29),
      ),
      body: Container(
         decoration: const BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 242, 242, 242),
                  Colors.white,
              ],
            )
              ),
          child: Column(children: [
            Container(
              height: 65,
              margin: const EdgeInsets.all(5),
              child: const TextField(
                textAlignVertical: TextAlignVertical.center,
                style:TextStyle(fontSize:18),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Введите название блюда",
                  prefixIcon: Icon(Icons.search, color: Colors.red,)
                ),
              ),
            ),
          
            Container(
              height: 50,
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
                              label: Text(items[index]['strCategory'], style: TextStyle(color: Color.fromARGB(255, 246, 246, 246)),),
                              selectedColor: Color.fromARGB(255, 198, 25, 13),
                              backgroundColor: Colors.red,
                              onSelected: (selected) {
                                if(selected){
                                  setState(() {
                                    context.read<FoodBloc>().add(FoodGetFoodEvent(category: items[index]['strCategory']));
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
            ),
            BlocBuilder<FoodBloc, FoodState>(
              builder: (context, state) {
                if(state is FoodStateLoaded){
                  List items = state.foods;
                  return Expanded(
                    child:GridView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: items.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: (120.0 / 185.0),
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10), 
                      itemBuilder:(context, index) {
                        return (
                          Container(
                            child: Column(
                              children: <Widget> [
                                Container(
                                  height: 140,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(items[index]['strMealThumb']),
                                      fit: BoxFit.cover) 
                                  ),
                                ),
                                Text(
                                  items[index]['strMeal'], 
                                  maxLines: 2,
                                  textAlign: TextAlign.center,)
                              ],
                            ),
                          )
                        );
                      }
                    )
                  );
                } else {
                  return 
                    const SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(),
                    );
                }
              },
            )
          ],
        ),
      )
    );
  }
}
