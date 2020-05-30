import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterrecipeapp/bloc/recipe/recipe_bloc.dart';

import 'bottom_loader.dart';
import 'recipe_single_item.dart';

class RecipeListBuilder extends StatelessWidget {
  final LoadedState currentState;
  final _scrollController = ScrollController();

  RecipeListBuilder(this.currentState);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notificaton) => _handleScrolling(notificaton, currentState, context),
      child: ListView.builder(
        itemBuilder: (context, position) {
          return position >= currentState.recipe.length
              ? BottomLoadingIndicator()
              : BuildRecipeSingleItem(currentState.recipe[position]);
        },
        itemCount: currentState.hasReachToEnd
            ? currentState.recipe.length
            : currentState.recipe.length + 1, // for showing bottom progress bar
        controller: _scrollController,
      ),
    );
  }

  bool _handleScrolling(notificaton, LoadedState currentState, BuildContext context) {
    if (notificaton is ScrollEndNotification && _scrollController.position.extentAfter == 0) {
      print('has reached to end of list '+currentState.hasReachToEnd.toString());
      if (!currentState.hasReachToEnd) {
        print('calling load more');
        BlocProvider.of<RecipeBloc>(context).add(LoadMoreEvent());
      }
    }
    return false;
  }
}





