import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterrecipeapp/bloc/recipe/recipe_bloc.dart';
import 'package:flutterrecipeapp/screen/widget/recipe_state_builder.dart';

import 'widget/search_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffcee),
      body: BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
        // Map your state and return the widget
        return Column(
          children: <Widget>[
            SearchBar(),
            Expanded(
              child: RecipeStateBuilder(),
            )
          ],
        );
      }),
    );
  }
}
