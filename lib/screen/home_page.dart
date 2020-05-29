import 'package:flutter/material.dart';
import 'package:flutterrecipeapp/constant/app_constant.dart';
import 'package:flutterrecipeapp/model/recipe_model.dart';
import 'package:flutterrecipeapp/repository/recipe_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RecipeRepository _repository = RecipeRepository();
  int _page = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe app'),
      ),
      body: Column(
        children: <Widget>[
          SearchBar(context, _repository),
          Expanded(
            child: buildFutureBuilder(),
          )
        ],
      ),
    );
  }

  Widget SearchBar(BuildContext context, RecipeRepository repository) {
    final _recipeQuery = TextEditingController();
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
              print('calling for qurey '+ _recipeQuery.text);
              repository.getRecipeList(query: _recipeQuery.text, page: 0);
            },
          )
        ],
      ),
    );
  }

  FutureBuilder<List<Result>> buildFutureBuilder() {
    return FutureBuilder(
      future: _repository.getRecipeList(query: "Pizza", page: _page),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          print('error ');
          return Center(child: CircularProgressIndicator());
        } else {
          List<Result> result = snapshot.data;
          return RefreshIndicator(
            onRefresh: () async => setState(() => {_page = 2}),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int position) {
                return ListTile(
                  title: Text(result[position].title),
                  subtitle: Text(result[position].ingredients),
                  leading: Image.network(
                    result[position].thumbnail.isEmpty
                        ? noImageUrl
                        : result[position].thumbnail,
                    height: 80,
                    width: 80,
                    fit: BoxFit.fitHeight,
                  ),
                  contentPadding:
                      EdgeInsets.only(top: 16, left: 16, right: 16),
                );
              },
              itemCount: result.length,
            ),
          );
        }
      },
    );
  }
}


