import 'package:flutter/material.dart';
import 'package:flutterrecipeapp/constant/app_constant.dart';
import 'package:flutterrecipeapp/model/recipe_model.dart';

class BuildRecipeSingleItem extends StatelessWidget {
  final Result _result;
  BuildRecipeSingleItem(this._result);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_result.title),
      subtitle: Text(_result.ingredients),
      leading: Image.network(
        _result.thumbnail.isEmpty
            ? noImageUrl
            : _result.thumbnail,
        height: 80,
        width: 80,
        fit: BoxFit.fitHeight,
      ),
      contentPadding: EdgeInsets.only(top: 16, left: 16, right: 16),
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
    );
  }
}