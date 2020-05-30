import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterrecipeapp/bloc/recipe/recipe_bloc.dart';

class SearchBar extends StatelessWidget {
  final _recipeQuery = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    var _bloc = context.bloc<RecipeBloc>();
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.grey[300]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'What you want to eat today...',
                  labelText: 'Search Recipe',
                  icon: Icon(Icons.fastfood)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter bloc.recipe';
                }
                return null;
              },
              controller: _recipeQuery,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              size: 25,
            ),
            onPressed: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              print('user enter:'+ _recipeQuery.text.trim());
              _bloc.add(SearchEvent(_recipeQuery.text.trim()));
            },
          )
        ],
      ),
    );
  }
}
