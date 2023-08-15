import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/food_bloc/food_bloc.dart';
import 'package:food_app/model/food.dart';
import 'package:food_app/repositories/food_repository.dart';
import 'package:food_app/screens/foodDetails.dart';
import '../bloc/category_bloc/categories_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final foodRepository = FoodRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) => CategoriesBloc(foodRepository: foodRepository)..add(CategoriesFetchEvent())),
        BlocProvider(create:(context) => FoodBloc(foodRepository: foodRepository)..add(FoodGetFoodEvent(category: 'Beef')))
      ], 
      child: MaterialApp(home: MyHomePage(foodRepository: foodRepository,))
    );
  }
}

class MyHomePage extends StatefulWidget {

  final FoodRepository foodRepository;

  MyHomePage({required this.foodRepository, super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState(foodRepository: foodRepository);
}

class _MyHomePageState extends State<MyHomePage> {

  final FoodRepository foodRepository;
  TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;

  _MyHomePageState({required this.foodRepository});

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
                  Color.fromARGB(255, 247, 247, 247),
                  Color.fromARGB(255, 239, 239, 239),
              ],
            )
              ),
          child: Column(children: [
            const SizedBox(height: 10,),
            Container(
              height: 65,
              margin: const EdgeInsets.all(5),
              child: BlocBuilder<FoodBloc, FoodState>(
                builder: (context, state) {
                  return TextField(
                    controller: _searchController,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(fontSize:18),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Введите название блюда " + (state.currentCategory),
                      prefixIcon: Icon(Icons.search, color: Colors.red,)
                    ),
                    onChanged: (name){
                      setState(() {
                        if(name.isNotEmpty){
                          context.read<FoodBloc>().add(SearchFoodEvent(
                            name: name, 
                            category: state.currentCategory));
                        }
                        else{
                          context.read<FoodBloc>().add(FoodGetFoodEvent(
                            category: state.currentCategory));
                        }
                      });
                    },
                  );
                }
              )
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
                              label: Text(items[index].title, style: TextStyle(color: Color.fromARGB(255, 246, 246, 246)),),
                              selectedColor: Color.fromARGB(255, 198, 25, 13),
                              backgroundColor: Colors.red,
                              onSelected: (selected) {
                                if(selected){
                                  setState(() {
                                    if(_searchController.text.isNotEmpty){
                                      context.read<FoodBloc>().add(SearchFoodEvent(
                                        name: _searchController.text, 
                                        category: items[index].title
                                      ));
                                  }
                                  else{
                                    context.read<FoodBloc>().add(FoodGetFoodEvent(
                                      category: items[index].title));
                                  }
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
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child:
                      BlocBuilder<CategoriesBloc, CategoriesState>(
                        builder: (context, state) {
                        final categories = context.select((CategoriesBloc bloc) => bloc.state.categories);
                        if(!state.isLoading){
                          return 
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).copyWith().size.width,
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    categories[_selectedCategoryIndex].title, 
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontSize: 32, 
                                      fontWeight: FontWeight.w300),),),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                  child: Column(
                                    children: <Widget> [
                                      Container(
                                        height: 220,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(categories[_selectedCategoryIndex].poster),
                                            fit: BoxFit.cover) 
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          categories[_selectedCategoryIndex].description.split('.').take(2).join('.')+".",
                                          textAlign: TextAlign.justify,),
                                      ) ,
                                    ],
                                  )
                                )
                              ],
                            );
                        } else {
                          return Center(
                            child: Container(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      }
                    )
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: const Text('Foods', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300),),),
                  ),
                  BlocBuilder<FoodBloc, FoodState>(
                    builder: (context, state) {
                      if(!state.isLoading){
                        List<Food> items = state.foods;
                        if(items.isEmpty){
                          return SliverToBoxAdapter(
                            child: Container(
                              height: 100,
                              child: Center(
                                child: Text("Nothing found", 
                                  style: TextStyle(fontSize: 24),)),
                          ));
                        }
                        return SliverGrid(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            childCount: items.length,
                            (BuildContext context, int index) {
                              return (
                                Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder:(context) => FoodDetailsWidget(
                                            foodRepository: foodRepository,
                                            id: items[index].id,
                                            title: items[index].title,
                                          ))
                                      );
                                    },
                                    child: Column(
                                      children: <Widget> [
                                        Container(
                                          height: 140,
                                          margin: EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(items[index].poster),
                                              fit: BoxFit.cover) 
                                          ),
                                        ),
                                        Text(
                                          items[index].title, 
                                          maxLines: 2,
                                          textAlign: TextAlign.center,)
                                      ],
                                  ),
                                ) 
                              )
                            );
                          }
                        )
                      );     
                    } else {
                      return 
                        SliverToBoxAdapter(
                          child: Container(
                            height: 100,
                            child: const Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(),
                              ),
                            )),
                        );    
                      }
                    },
                  )
                ],
              ),
            )
          ]
        )
      )
    );
  }
}
