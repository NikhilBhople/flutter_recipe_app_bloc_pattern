import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterrecipeapp/bloc/recipe/recipe_bloc.dart';
import 'package:flutterrecipeapp/repository/recipe_repository.dart';
import 'package:flutterrecipeapp/screen/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC Pattern',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
          // Creating Bloc provider here and adding first event as AppStarted
          create: (context) =>
              RecipeBloc(repository: RecipeRepository())..add(AppStated()),
          child: HomePage()),
    );
  }
}
