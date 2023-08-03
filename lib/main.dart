import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/category_bloc/categories_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => CategoriesBloc()..add(CategoriesFetchEvent()),
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
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories App'),
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(

        builder: (context, state) {
          final items = context.select((CategoriesBloc bloc) => bloc.state.categories);
          return 
            !context.read<CategoriesBloc>().state.isLoading ?
              ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return(
                    Container(
                      child: Column(
                        children: [
                          Image(image: NetworkImage(items[index]['strCategoryThumb'])),
                          Text(items[index]['strCategory'])
                        ],
                      ),
                    )
                  );
                },
            ): const CircularProgressIndicator();
        },
      )
    );
  }
}
