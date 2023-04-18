import 'package:my_2048/repositories/score_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/game_bloc.dart';
import 'game_layout.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});
  static const routeName = 'game';

  @override
  Widget build(BuildContext context) {
    final boardSize = ModalRoute.of(context)!.settings.arguments as int;

    return BlocProvider<GameBloc>(
      create: (context) =>
          GameBloc(boardSize: boardSize, scoreRepository: ScoreRepository())..add(StartGame()),
      child: SafeArea(
        child: Scaffold(
          body: GameLayout(boardSize: boardSize),
        ),
      ),
    );
  }
}
