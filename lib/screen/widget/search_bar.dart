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
      padding: EdgeInsets.only(left: 16,right: 16,top: 40,bottom: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)), color: Colors.orange[300]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'What you want to eat today...',hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Search Recipe',labelStyle: TextStyle(color: Colors.black),
                  icon: Icon(Icons.fastfood, color: Colors.black,)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter recipe';
                }
                return null;
              },
              controller: _recipeQuery,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              size: 25,
              color: Colors.black,
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
