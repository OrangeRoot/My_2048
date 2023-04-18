part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class MoveUp extends GameEvent {}

class MoveDown extends GameEvent {}

class MoveRight extends GameEvent {}

class MoveLeft extends GameEvent {}

class StartGame extends GameEvent {}

class RestartGame extends GameEvent {}

class UndoMove extends GameEvent {}
