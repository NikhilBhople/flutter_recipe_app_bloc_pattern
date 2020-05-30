import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterrecipeapp/bloc/recipe/recipe_bloc.dart';
import 'package:flutterrecipeapp/screen/widget/recipe_list.dart';

class RecipeStateBuilder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var currentState = BlocProvider.of<RecipeBloc>(context).state;

    if (currentState is InitialState) {
      return Center(
        child: Text('What recipe do you want to cook today'),
      );
    } else if (currentState is LoadingState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (currentState is LoadedState) {
      if (currentState.recipe.isEmpty) {
        return Center(
          child: Text('No recipe found. Try different recipe'),
        );
      }
      return RecipeListBuilder(currentState);
    }else if (currentState is ErrorState) {
      return Center(
        child: Text('Something went wrong. Please check internet connection'),
      );
    }
  }
}
