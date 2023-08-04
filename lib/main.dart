import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/category_bloc/categories_bloc.dart';
import 'package:food_app/widgets/categoriesList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 65,
              margin: EdgeInsets.all(5),
              child: TextField(
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
              child: CategoriesList()
            ),
          ],
        ),
      )
    );
  }
}
