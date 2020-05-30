import 'package:flutterrecipeapp/constant/app_constant.dart';
import 'package:flutterrecipeapp/model/recipe_model.dart';
import 'package:flutterrecipeapp/repository/base_recipe_repository.dart';
import 'package:http/http.dart' as http;

class RecipeRepository extends BaseRecipeRepository {
  // If you're making multiple requests to the same server,
  // you can keep open a persistent connection by using a Client rather than making one-off requests.
  // If you do this, make sure to close the client when you're done:
  final http.Client _httpClient;

  RecipeRepository({http.Client httpClient})
      : _httpClient = httpClient ?? http.Client();
  // if no parameter is passed in then instantiate new http client

  @override
  Future<List<Result>> getRecipeList({String query, int page}) async {
    final url = '$baseUrl?q=$query&p=$page';
    print(url);
    final response = await _httpClient.get(url);
    if (response.statusCode == 200) {
      print('success ' + response.statusCode.toString());
      return recipeModelFromJson(response.body).results;
    } else {
      print('got error code ' + response.statusCode.toString());
    }
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}
