part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState({
    required this.bestScore,
    required this.score,
    required List<List<Tile>> board,
  }) : _board = board;
  final List<List<Tile>> _board;
  final int bestScore;
  final int score;

  @override
  List<Object> get props => [_board];

  List<List<Tile>> get board => [
        ..._board.map((row) => [...row])
      ];
}

class GameInitial extends GameState {
  GameInitial({required int boardSize, required super.bestScore, required super.score})
      : super(
          board: List.generate(
            boardSize,
            (x) => List.generate(boardSize, (y) => Tile.empty(UniqueKey()), growable: false),
            growable: false,
          ),
        );
}

class GameUpdateState extends GameState {
  const GameUpdateState({required super.board, required super.bestScore, required super.score});
}

class GameEndDefeat extends GameState {
  const GameEndDefeat({required super.board, required super.bestScore, required super.score});
}
