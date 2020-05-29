part of 'recipe_bloc.dart';

@immutable
abstract class RecipeEvent extends Equatable {
  // Event is user interaction to your screen
  @override
  List<Object> get props => [];
}

class AppStated extends RefreshEvent {}

class SearchEvent extends RecipeEvent {
  final String query;

  SearchEvent(this.query);
  @override
  List<Object> get props => [query];
}

class RefreshEvent extends RecipeEvent {}

class LoadMoreEvent extends RecipeEvent {}


