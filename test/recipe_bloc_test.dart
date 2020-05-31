import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutterrecipeapp/bloc/recipe/recipe_bloc.dart';
import 'package:flutterrecipeapp/model/recipe_model.dart';
import 'package:mockito/mockito.dart';

import 'package:flutterrecipeapp/repository/recipe_repository.dart';

class MockRecipeRepository extends Mock implements RecipeRepository {}

void main() {
  const QUERY = 'banana';
  const PAGE_NUMBER = 1;
  Result recipe =
      Result(title: 'banana', href: '', ingredients: '', thumbnail: '');
  RecipeRepository repository;
  RecipeBloc bloc;

  setUp(() {
    repository = MockRecipeRepository();
    bloc = RecipeBloc(repository: repository);
  });

  tearDown(() {
    bloc.close();
  });

  group('RecipeBloc testing', () {
    test('throw AssertionError if RecipeRepository is null', () {
      expect(() => RecipeBloc(repository: null), throwsA(isAssertionError));
    });

    test('initial state is correct', () {
      emits([InitialState(), bloc.state]);
    });

    // Test cases for SearchEvent
    test(
        'emit [InitialState, LoadingState, ErrorState] when getRecipeList throw exc on SearchEvent',
        () {
      when(repository.getRecipeList(query: QUERY, page: PAGE_NUMBER))
          .thenThrow(throwsException);

      expectLater(
          bloc, emitsInOrder([InitialState(), LoadingState(), ErrorState()]));

      bloc.add(SearchEvent(QUERY));
    });

    test(
        'emit [InitialState, LoadingState, LoadedState] when getRecipeList success on SearchEvent',
        () {
      when(repository.getRecipeList(query: QUERY, page: PAGE_NUMBER))
          .thenAnswer((realInvocation) => Future.value([recipe]));

      expectLater(
          bloc,
          emitsInOrder([
            InitialState(),
            LoadingState(),
            LoadedState(recipe: [recipe], hasReachToEnd: false)
          ]));

      bloc.add(SearchEvent(QUERY));
    });

    test(
        'emit [InitialState, LoadingState, LoadedState] when getRecipeList success but empty list on SearchEvent',
        () {
      when(repository.getRecipeList(query: QUERY, page: PAGE_NUMBER))
          .thenAnswer((realInvocation) => Future.value([]));

      expectLater(
          bloc,
          emitsInOrder([
            InitialState(),
            LoadingState(),
            LoadedState(recipe: [], hasReachToEnd: true)
          ]));

      bloc.add(SearchEvent(QUERY));
    });

    // LoadMoreEvent test cases
    test(
        'emit [InitialState, LoadedState] on getRecipeList Success on LoadMoreEvent',
        () {
      bloc.query = QUERY;
      when(repository.getRecipeList(query: QUERY, page: 1))
          .thenAnswer((_) => Future.value([recipe]));

      expectLater(
          bloc,
          emitsInOrder([
            InitialState(),
            LoadedState(recipe: [recipe], hasReachToEnd: false)
          ]));

      bloc.add(LoadMoreEvent());
    });

    test(
        'emit [InitialState, LoadedState] on getRecipeList Success but empty list on LoadMoreEvent',
        () {
      bloc.query = QUERY;
      when(repository.getRecipeList(query: QUERY, page: 1))
          .thenAnswer((_) => Future.value([]));

      expectLater(
          bloc,
          emitsInOrder(
              [InitialState(), LoadedState(recipe: [], hasReachToEnd: true)]));

      bloc.add(LoadMoreEvent());
    });

    test(
        'emit [InitialState, ErrorState] on getRecipeList throw error LoadMoreEvent',
        () {
      bloc.query = QUERY;
      when(repository.getRecipeList(query: QUERY, page: 1))
          .thenThrow(throwsException);

      expectLater(bloc, emitsInOrder([InitialState(), ErrorState()]));

      bloc.add(LoadMoreEvent());
    });

    // RefreshEvent test cases
    test(
        'emit [InitialState,ErrorState] when no query string is present for RefreshEvent',
        () async {
      when(repository.getRecipeList(query: QUERY, page: PAGE_NUMBER))
          .thenThrow(throwsException);

      expectLater(bloc, emitsInOrder([InitialState(), ErrorState()]));

      bloc.add(RefreshEvent());
    });

    test('emit [LoadedState] when get success response from getRecipeList',
        () async {
      when(repository.getRecipeList(query: QUERY, page: PAGE_NUMBER))
          .thenAnswer((_) => Future.value([recipe]));
      bloc.query = 'banana';

      expectLater(
          bloc,
          emitsInOrder([
            InitialState(),
            LoadedState(recipe: [recipe], hasReachToEnd: false)
          ]));

      bloc.add(RefreshEvent());
    });

    // calling SearchEvent AND LoadMoreEvent
    test(
        'emit [InitialState, LoadingState, LoadedState, LoadedState] on getting success for SearchEvent and LoadMoreEvent',
        () {
      when(repository.getRecipeList(query: QUERY, page: PAGE_NUMBER))
          .thenAnswer((realInvocation) => Future.value([recipe]));
      when(repository.getRecipeList(query: QUERY, page: 2))
          .thenAnswer((realInvocation) => Future.value([recipe]));

      expectLater(
          bloc,
          emitsInOrder([
            InitialState(),
            LoadingState(),
            LoadedState(recipe: [recipe], hasReachToEnd: false),
            LoadedState(recipe: [recipe, recipe], hasReachToEnd: false)
          ]));

      bloc.add(SearchEvent(QUERY));
      bloc.add(LoadMoreEvent());
    });
  });
}
