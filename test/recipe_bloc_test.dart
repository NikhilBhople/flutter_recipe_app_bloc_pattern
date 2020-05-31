import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterrecipeapp/bloc/recipe/recipe_bloc.dart';
import 'package:flutterrecipeapp/model/recipe_model.dart';
import 'package:mockito/mockito.dart';

import 'package:flutterrecipeapp/repository/recipe_repository.dart';

class MockRecipeRepository extends MockBloc<RecipeEvent, RecipeState>
    implements RecipeRepository {}

void main() {
  const QUERY = 'banana';
  const PAGE_NUMBER = 1;
  RecipeRepository repository;
  RecipeBloc bloc;

  setUp(() {
    repository = MockRecipeRepository();
    bloc = RecipeBloc(repository: repository);
  });

  tearDown(() {
    bloc.close();
  });

  group(
    'RecipeBloc testing',
    () {
      test('throw AssertionError if RecipeRepository is null', () {
        expect(() => RecipeBloc(repository: null), throwsA(isAssertionError));
      });
    },
  );

  //build should be used for all bloc initialization and preparation and must return the bloc under test.
  //
  //act is an optional callback which will be invoked with the bloc under test and should be used to add events to the bloc.
  //
  //expect is an Iterable<State> which the bloc under test is expected to emit after act is executed.

  group('Search Event testing', () {
    test('initial state is correct', () {
      emits([InitialState(), bloc.state]);
    });

    blocTest(
      'emit [LoadingState,ErrorState] when getRecipeList throw exception',
      build: () async {
        when(repository.getRecipeList(query: QUERY, page: PAGE_NUMBER))
            .thenThrow(throwsException);
        return bloc;
      },
      act: (bloc) => bloc.add(SearchEvent(QUERY)),
      expect: [LoadingState(), ErrorState()],
    );

    test('emit [LoadingState, LoadedState] when get success', () {
      when(repository.getRecipeList(query: QUERY, page: PAGE_NUMBER))
          .thenAnswer((realInvocation) => Future.value(getDummyList()));
      bloc.add(SearchEvent(QUERY));
      var state = LoadedState(recipe: getDummyList(), hasReachToEnd: false);
      expect([LoadingState(), state], [LoadingState(), state]);
      emits([LoadingState(), LoadedState()]);
    });

    test(
        'emit [LoadingState, LoadedState(hasReachToEnd = false)] when get empty list',
        () {
      when(repository.getRecipeList(query: QUERY, page: PAGE_NUMBER))
          .thenAnswer((_) => Future.value(getEmptyList()));
      var state = LoadedState(recipe: getEmptyList(), hasReachToEnd: true);
      emits([LoadingState(), state]);
      expect([LoadingState(), state], [LoadingState(), state]);
    });
  });

  group('Refresh Event Testing', () {
    test('emit [ErrorState] when no query string is present', () async {
      when(repository.getRecipeList(query: QUERY, page: PAGE_NUMBER))
          .thenThrow(throwsException);
      bloc.add(RefreshEvent());

      emits([ErrorState()]);
    });

    test('emit [ErrorState] when get exception from getRecipeList', () async {
      when(repository.getRecipeList(query: QUERY, page: PAGE_NUMBER))
          .thenThrow(throwsException);
      bloc.query = 'banana';
      bloc.add(RefreshEvent());

      emits([ErrorState()]);
    });

    test('emit [LoadedState] when get success response from getRecipeList',
        () async {
      when(repository.getRecipeList(query: QUERY, page: PAGE_NUMBER))
          .thenAnswer((_) => Future.value(getDummyList()));
      bloc.query = 'banana';
      bloc.add(RefreshEvent());

      emits([LoadedState()]);
    });
  });

  group('LoadMoreEvent testing', () {
    test(
        'emit [LoadedState[previoslist, hasReachToEnd= true]] when get exception for load more',
        () async {
      bloc.pageNumber = 2;
      bloc.query = QUERY;
      when(repository.getRecipeList(query: QUERY, page: 2))
          .thenThrow(throwsException);
      var loadedState = LoadedState(recipe: [], hasReachToEnd: true);
      bloc.add(LoadMoreEvent());
      emits([LoadingState()]);
      expect([loadedState], [loadedState]);
    });

    test('emit [LoadedState()] when get success', () async {
      bloc.pageNumber = 2;
      bloc.query = QUERY;
      when(repository.getRecipeList(query: QUERY, page: 2))
          .thenAnswer((_) => Future.value(getDummyList()));
      bloc.add(LoadMoreEvent());
      emits([LoadingState()]);
      expect([LoadedState()], [LoadedState()]);
    });
  });
}

FutureOr<List<Result>> getEmptyList() {
  return [];
}

List<Result> getDummyList() {
  Result result = Result(
      title: 'banana', href: 'sdfd', ingredients: 'sdfdf', thumbnail: 'sdfdf');
  return [result, result, result, result];
}
