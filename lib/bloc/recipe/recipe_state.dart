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
  final bool hasReachToEnd;

  LoadedState({@required this.recipe,@required this.hasReachToEnd});

  @override
  List<Object> get props => [recipe, hasReachToEnd];
}

class ErrorState extends RecipeState {}
