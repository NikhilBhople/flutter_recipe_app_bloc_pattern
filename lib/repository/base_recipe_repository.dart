import 'package:flutterrecipeapp/model/recipe_model.dart';

abstract class BaseRecipeRepository {
  Future<List<Result>> getRecipeList({String query, int page});
  void dispose();
}