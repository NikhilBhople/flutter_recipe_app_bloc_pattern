import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterrecipeapp/model/recipe_model.dart';
import 'package:flutterrecipeapp/repository/recipe_repository.dart';
import 'package:meta/meta.dart';

part 'recipe_event.dart';

part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  // add dependency to perform your business logic (we need repository here)
  final RecipeRepository _repository;
  String query;
  int pageNumber = 1;
  List<Result> recipeList = [];

  RecipeBloc({@required RecipeRepository repository})
      : assert(repository != null),
        _repository = repository;

  @override
  RecipeState get initialState => InitialState();

  @override
  Stream<RecipeState> mapEventToState(RecipeEvent event) async* {
    if (event is SearchEvent) {
     yield* _mapToSearchEvent(event);
    }else if (event is RefreshEvent) {
     yield*  _getRecipes(query, []);
    }else if (event is LoadMoreEvent) {
     yield* _getRecipes(query, recipeList, page: pageNumber);
    }
  }

  Stream<RecipeState> _mapToSearchEvent(SearchEvent event) async* {
    query = event.query;
    yield InitialState(); // clearing previous list
    yield LoadingState(); // showing loading indicator
    yield* _getRecipes(event.query, []); // get recipes
  }

  Stream<RecipeState> _getRecipes(String query, List<Result> results, {int page = 1}) async* {
    print('inside getrecipre: '+query);
    try{
      recipeList = results + await _repository.getRecipeList(query: query, page: page);
      pageNumber++;
      yield LoadedState(recipe: recipeList, hasReachToEnd: results.isEmpty ? true : false);
    }catch (ex) {
      print('inside bloc: '+ex);
      yield ErrorState();
    }
  }
}
