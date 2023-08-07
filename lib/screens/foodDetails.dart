import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/food_detail_bloc/food_details_bloc.dart';
import 'package:food_app/model/foodDetails.dart';
import 'package:food_app/repositories/food_repository.dart';

class FoodDetailsWidget extends StatefulWidget {
  final FoodRepository foodRepository;
  final String id;
  final String title;

  const FoodDetailsWidget({required this.foodRepository, required this.id, required this.title, super.key});

  @override
  State<FoodDetailsWidget> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color.fromARGB(255, 201, 41, 29),
        centerTitle: true,
      ),
      body: BlocProvider(create: (context) => FoodDetailsBloc(
        foodRepository: widget.foodRepository)..add(FoodDetailsGetFoodEvent(id: widget.id)),
        child: BlocBuilder<FoodDetailsBloc, FoodDetailsState>(
          builder: (context, state) {
            if(state is FoodDetailsStateLoaded){
              FoodDetail food = state.food;
              List<String> tags = food.tags.split(',');
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(food.poster),
                          fit: BoxFit.cover)
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).copyWith().size.width,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                      child: Text(food.title, 
                        style: const TextStyle(
                          fontSize: 32, 
                          fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      width: MediaQuery.of(context).copyWith().size.width,
                      padding: EdgeInsets.only(left: 10),
                      child: Text('Area: ${food.area}', 
                        style: const TextStyle(
                          fontSize: 24),),
                    ),
                    food.tags!='' ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      height: 45,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(width: 5,),
                          Wrap(
                            spacing: 4.0,
                            runSpacing: 0.0,
                            children: List<Widget>.generate(
                              tags.length,
                              (int index) {
                                return ChoiceChip(
                                  selected: false,
                                  disabledColor: Color.fromARGB(255, 208, 208, 208),
                                  labelStyle: TextStyle(color: Colors.black),
                                  label: Text(tags[index]),
                                );
                              }
                            ).toList(),
                          ),
                        ],
                      ),
                    ): Container(),
                    Container(
                      width: MediaQuery.of(context).copyWith().size.width,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Instruction", style: TextStyle(fontSize: 24),),
                          SizedBox(height: 5,),
                          Text(food.instruction),
                        ],
                      )
                    ),
                  ],
                ),
              ); 
            } else {
              return Center(
                child:  Container(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      )
    );
  }

}