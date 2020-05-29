import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterrecipeapp/bloc/recipe/recipe_bloc.dart';
import 'package:flutterrecipeapp/constant/app_constant.dart';
import 'package:flutterrecipeapp/model/recipe_model.dart';

import 'widget/search_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  RecipeBloc _recipeBloc;

  @override
  void initState() {
    super.initState();
    _recipeBloc = BlocProvider.of<RecipeBloc>(context);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter == 0) {
      _recipeBloc.add(LoadMoreEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe app'),
      ),
      body: BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
        // Map your state and return the widget
        return Column(
          children: <Widget>[
            SearchBar(context, _recipeBloc),
            Expanded(
              child: _buildState(state),
            )
          ],
        );
      }),
    );
  }

  Widget _buildState(RecipeState state) {
    if (state is InitialState) {
      return Center(
        child: Text('What recipe do you want to cook today'),
      );
    } else if (state is LoadingState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is LoadedState) {
      if (state.recipe.isEmpty) {
        return Center(
          child: Text('No recipe found. Try different recipe'),
        );
      }
      return ListView.builder(
        itemBuilder: (context, position) {
          return position >= state.recipe.length
              ? BottomLoader()
              : ShowRecipe(state.recipe[position]);
        },
        itemCount: state.hasReachToEnd
            ? state.recipe.length
            : state.recipe.length + 1, // for showing bottom progress bar
        controller: _scrollController,
      );
    }else if (state is ErrorState) {
      return Center(
        child: Text('Something went wrong. Please check internet connection'),
      );
    }
  }

  ListTile ShowRecipe(Result recipe) {
    return ListTile(
          title: Text(recipe.title),
          subtitle: Text(recipe.ingredients),
          leading: Image.network(
            recipe.thumbnail.isEmpty
                ? noImageUrl
                : recipe.thumbnail,
            height: 80,
            width: 80,
            fit: BoxFit.fitHeight,
          ),
          contentPadding: EdgeInsets.only(top: 16, left: 16, right: 16),
        );
  }


}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
