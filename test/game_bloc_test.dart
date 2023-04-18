import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_2048/play_game/bloc/game_bloc.dart';
import 'package:my_2048/repositories/score_repository.dart';

import 'mocks/score_repository.mocks.dart';
// import 'package:mockito/annotations.dart';
// @GenerateNiceMocks([MockSpec<ScoreRepository>()])

void main() {
  group('GameBloc:', () {
    late ScoreRepository scoreRepository;
    late GameBloc gameBloc;

    setUp(() {
      scoreRepository = MockScoreRepository();
      gameBloc = GameBloc(
        scoreRepository: scoreRepository,
        boardSize: 3,
      );
    });

    blocTest(
      'emit GameUpdateState on MoveUp',
      build: () => gameBloc,
      act: (bloc) => bloc.add(MoveUp()),
      expect: () => [isA<GameUpdateState>()],
    );
    blocTest(
      'emit GameUpdateState on MoveDown',
      build: () => gameBloc,
      act: (bloc) => bloc.add(MoveDown()),
      expect: () => [isA<GameUpdateState>()],
    );
    blocTest(
      'emit GameUpdateState on MoveLeft',
      build: () => gameBloc,
      act: (bloc) => bloc.add(MoveLeft()),
      expect: () => [isA<GameUpdateState>()],
    );

    blocTest(
      'emit GameUpdateState on MoveRight',
      build: () => gameBloc,
      act: (bloc) => bloc.add(MoveRight()),
      expect: () => [isA<GameUpdateState>()],
    );
    blocTest(
      'emit GameUpdateState on StartGame',
      build: () => gameBloc,
      act: (bloc) => bloc.add(MoveRight()),
      expect: () => [isA<GameUpdateState>()],
    );
    blocTest(
      'emit GameInitial on RestartGame',
      build: () => gameBloc,
      act: (bloc) => bloc.add(RestartGame()),
      wait: const Duration(milliseconds: 300),
      expect: () => [isA<GameInitial>(), isA<GameUpdateState>()],
    );
    blocTest(
      'emit GameUpdateState on UndoMove',
      build: () => gameBloc,
      act: (bloc) => bloc.add(UndoMove()),
      expect: () => [isA<GameUpdateState>()],
    );
  });
}
