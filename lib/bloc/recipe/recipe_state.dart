part of 'recipe_bloc.dart';

@immutable
abstract class RecipeState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends RecipeState {}

class LoadingState extends RecipeState {}

class LoadedState extends RecipeState {
  final List<Result> recipe;

  LoadedState(this.recipe);
}

class ErrorState extends RecipeState {}