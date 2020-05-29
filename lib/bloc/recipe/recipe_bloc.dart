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
  int pageNumber = 0;

  RecipeBloc({@required RecipeRepository repository})
      : assert(repository != null),
        _repository = repository;

  @override
  RecipeState get initialState => InitialState();

  @override
  Stream<RecipeState> mapEventToState(RecipeEvent event) async* {
    if (event is SearchEvent) {
      _mapToSearchEvent(event);
    }else if (event is RefreshEvent) {
      _getRecipes(query, []);
    }else if (event is LoadMoreEvent) {
      _getRecipes(query, event.recipe, page: pageNumber);
    }
  }

  Stream<RecipeState> _mapToSearchEvent(SearchEvent event) async* {
    query = event.query;
    yield InitialState(); // clearing previous list
    yield LoadingState(); // showing loading indicator
    yield* _getRecipes(event.query, []); // get recipes
  }

  Stream<RecipeState> _getRecipes(String query, List<Result> results, {int page = 0}) async* {
    try{
      var list = results + await _repository.getRecipeList(query: query, page: page);
      pageNumber++;
      yield LoadedState(list);
    }catch (ex) {
      print(ex);
      yield ErrorState();
    }
  }
}
