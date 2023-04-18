import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:my_2048/repositories/score_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../models/tile.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final ScoreRepository scoreRepository;
  final int boardSize;
  int pointsGained = 0;
  List<List<Tile>> backup = [];

  GameBloc({required this.scoreRepository, required this.boardSize})
      : super(GameInitial(boardSize: boardSize, score: 0, bestScore: 0)) {
    on<StartGame>(_onStartGame);
    on<MoveUp>(_onMoveUp);
    on<MoveDown>(_onMoveDown);
    on<MoveRight>(_onMoveRight);
    on<MoveLeft>(_onMoveLeft);
    on<RestartGame>(_onRestartGame);
    on<UndoMove>(_onUndoMove);
  }

  void _onUndoMove(GameEvent event, Emitter<GameState> emit) {
    emit(GameUpdateState(
      board: backup,
      score: state.score - pointsGained,
      bestScore: state.bestScore,
    ));
  }

  void _onStartGame(GameEvent event, Emitter<GameState> emit) async {
    var startingBoard =
        state.board.map((e) => e.map((e) => e.copyWith(isNew: false)).toList()).toList();
    var newBoard = _addRandomTile([...startingBoard]);
    var newBoard2 = _addRandomTile([...newBoard]);

    int randomIndex = Random().nextInt(boardSize * boardSize);
    int randomIndex2 = Random().nextInt(boardSize * boardSize);
    while (randomIndex2 == randomIndex) {
      randomIndex2 = Random().nextInt(boardSize * boardSize);
    }
    int randomNumber = Random().nextInt(10) == 0 ? 4 : 2;
    int randomNumber2 = Random().nextInt(10) == 0 ? 4 : 2;
    int row = randomIndex ~/ boardSize;
    int col = randomIndex % boardSize;
    int row2 = randomIndex2 ~/ boardSize;
    int col2 = randomIndex2 % boardSize;
    startingBoard[row][col] = Tile.empty(UniqueKey()).copyWith(number: randomNumber);
    startingBoard[row2][col2] = Tile.empty(UniqueKey()).copyWith(number: randomNumber2);
    var bestScore = await scoreRepository.getBestScore(boardSize);
    emit(GameUpdateState(
      board: newBoard2,
      score: 0,
      bestScore: 0,
    ));
    backup = [...newBoard];
  }

  void _onRestartGame(GameEvent event, Emitter<GameState> emit) async {
    emit(GameInitial(boardSize: boardSize, bestScore: state.bestScore, score: 0));
    _onStartGame(event, emit);
  }

  void _onMoveUp(GameEvent event, Emitter<GameState> emit) {
    pointsGained = 0;
    backup = [...state.board];
    var finalizedBoard =
        state.board.map((e) => e.map((e) => e.copyWith(isNew: false)).toList()).toList();
    var transposedBoard = _transposeBoard(finalizedBoard);
    var mergedBoard = _merge(transposedBoard);
    var updatedBoard = _transposeBoard(mergedBoard);
    var newBoard = _addRandomTile(updatedBoard);
    var newScore = state.score + pointsGained;
    if (state.bestScore < newScore) {
      scoreRepository.setNewScore(boardSize, newScore);
    }

    emit(GameUpdateState(
      board: newBoard,
      score: newScore,
      bestScore: state.bestScore > newScore ? state.bestScore : newScore,
    ));
    if (_gameEnded(state.board)) {
      emit(GameEndDefeat(
        board: newBoard,
        bestScore: state.bestScore > newScore ? state.bestScore : newScore,
        score: newScore,
      ));
    }
  }

  void _onMoveDown(GameEvent event, Emitter<GameState> emit) {
    pointsGained = 0;
    backup = [...state.board];
    var finalizedBoard =
        state.board.map((e) => e.map((e) => e.copyWith(isNew: false)).toList()).toList();

    var transposedBoard = _transposeBoard(finalizedBoard);
    var reversedBoard = _reverseBoard(transposedBoard);
    var mergedBoard = _merge(reversedBoard);
    var revBoard = _reverseBoard(mergedBoard);
    var updatedBoard = _transposeBoard(revBoard);
    var newBoard = _addRandomTile(updatedBoard);
    var newScore = state.score + pointsGained;
    if (state.bestScore < newScore) {
      scoreRepository.setNewScore(boardSize, newScore);
    }

    emit(GameUpdateState(
      board: newBoard,
      score: newScore,
      bestScore: state.bestScore > newScore ? state.bestScore : newScore,
    ));
    if (_gameEnded(state.board)) {
      emit(GameEndDefeat(
        board: newBoard,
        bestScore: state.bestScore > newScore ? state.bestScore : newScore,
        score: newScore,
      ));
    }
  }

  void _onMoveRight(GameEvent event, Emitter<GameState> emit) {
    pointsGained = 0;
    backup = [...state.board];
    var finalizedBoard =
        state.board.map((e) => e.map((e) => e.copyWith(isNew: false)).toList()).toList();
    var reversedBoard = _reverseBoard(finalizedBoard);
    var mergedBoard = _merge(reversedBoard);
    var updatedBoard = _reverseBoard(mergedBoard);
    var newBoard = _addRandomTile(updatedBoard);
    var newScore = state.score + pointsGained;
    if (state.bestScore < newScore) {
      scoreRepository.setNewScore(boardSize, newScore);
    }

    emit(GameUpdateState(
      board: newBoard,
      score: newScore,
      bestScore: state.bestScore > newScore ? state.bestScore : newScore,
    ));
    if (_gameEnded(state.board)) {
      emit(GameEndDefeat(
        board: newBoard,
        bestScore: state.bestScore > newScore ? state.bestScore : newScore,
        score: newScore,
      ));
    }
  }

  void _onMoveLeft(GameEvent event, Emitter<GameState> emit) {
    pointsGained = 0;
    backup = [...state.board];
    var finalizedBoard =
        state.board.map((e) => e.map((e) => e.copyWith(isNew: false)).toList()).toList();

    var updatedBoard = _merge(finalizedBoard);
    var newBoard = _addRandomTile(updatedBoard);
    var newScore = state.score + pointsGained;
    if (state.bestScore < newScore) {
      scoreRepository.setNewScore(boardSize, newScore);
    }
    emit(GameUpdateState(
      board: newBoard,
      score: newScore,
      bestScore: state.bestScore > newScore ? state.bestScore : newScore,
    ));
    if (_gameEnded(state.board)) {
      emit(GameEndDefeat(
        board: newBoard,
        bestScore: state.bestScore > newScore ? state.bestScore : newScore,
        score: newScore,
      ));
    }
  }

  bool _gameEnded(List<List<Tile>> board) {
    if (board.expand((element) => element.map((e) => e.number)).contains(0)) return false;

    for (var row in board) {
      for (var i = 0; i < boardSize - 1; i++) {
        if (row[i].number == row[i + 1].number) return false;
      }
    }
    for (var row in _transposeBoard(board)) {
      for (var i = 0; i < row.length - 1; i++) {
        if (row[i].number == row[i + 1].number) return false;
      }
    }
    return true;
  }

  List<List<Tile>> _transposeBoard(List<List<Tile>> board) {
    for (int i = 0; i < boardSize; i++) {
      for (int j = i + 1; j < boardSize; j++) {
        Tile temp = board[i][j];
        board[i][j] = board[j][i];
        board[j][i] = temp;
      }
    }
    return board;
  }

  List<List<Tile>> _reverseBoard(List<List<Tile>> board) {
    for (int i = 0; i < boardSize; i++) {
      board[i] = board[i].reversed.toList();
    }
    return board;
  }

  List<List<Tile>> _merge(List<List<Tile>> stage) {
    for (int i = 0; i < boardSize; i++) {
      stage[i] = _sumArray(stage[i]);
    }
    return stage;
  }

  List<Tile> _sumArray(List<Tile> array) {
    List<Tile> newArray = [];
    int? indToSum;
    for (var i = 0; i < boardSize; i++) {
      if (array[i].number != 0) {
        if (indToSum == null) {
          indToSum = i;
          continue;
        }
        if (array[i].number == array[indToSum].number) {
          newArray.add(array[i].copyWith(number: array[i].number * 2));
          pointsGained += array[i].number;
          indToSum = null;
        } else {
          newArray.add(array[indToSum]);
          indToSum = i;
        }
      }
    }
    if (indToSum != null) {
      newArray.add(array[indToSum]);
    }
    if (newArray.length != array.length) {
      return [
        ...newArray,
        ...List.generate(
          array.length - newArray.length,
          (i) => Tile.empty(UniqueKey()),
        ),
      ];
    }

    return newArray;
  }

  List<List<Tile>> _addRandomTile(List<List<Tile>> board) {
    bool nothingChanged = true;
    for (var i = 0; i < boardSize; i++) {
      if (!listEquals(board[i], state.board[i])) {
        nothingChanged = false;
      }
    }
    if (nothingChanged) {
      return board;
    }
    List<int> emptyTiles = [];

    for (int i = 0; i < boardSize; i++) {
      for (int j = 0; j < boardSize; j++) {
        if (board[i][j].number == 0) {
          emptyTiles.add(i * boardSize + j);
        }
      }
    }
    if (emptyTiles.isNotEmpty) {
      int randomIndex = Random().nextInt(emptyTiles.length);
      int randomNumber = Random().nextInt(10) == 0 ? 4 : 2;
      int row = emptyTiles[randomIndex] ~/ boardSize;
      int col = emptyTiles[randomIndex] % boardSize;

      board[row][col] = board[row][col].copyWith(number: randomNumber, isNew: true);
    }
    return board;
  }
}
