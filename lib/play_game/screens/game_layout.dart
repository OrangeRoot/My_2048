import 'package:my_2048/play_game/models/tile.dart';
import 'package:my_2048/play_game/widgets/animated_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/game_bloc.dart';
import '../widgets/swipe_detector.dart';

class GameLayout extends StatelessWidget {
  const GameLayout({super.key, required this.boardSize});
  final int boardSize;

  Widget _buildStage(List<List<Tile>> board, double boardWidth, bool theEnd, BuildContext context) {
    List<Widget> tiles = [];
    final tileSize = (boardWidth - 20) / boardSize;
    for (var i = 0; i < boardSize; i++) {
      for (var j = 0; j < boardSize; j++) {
        tiles.add(
          Positioned(
            top: i * tileSize,
            left: j * tileSize,
            child: SizedBox(
              height: tileSize,
              width: tileSize,
              child: Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: const Color(0xffcdc1b4),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        );
      }
    }

    for (var i = 0; i < boardSize; i++) {
      for (var j = 0; j < boardSize; j++) {
        if (board[i][j].number != 0) {
          tiles.add(
            AnimatedTile(
              key: ValueKey(board[i][j].key),
              tileData: board[i][j],
              tileSize: tileSize,
              x: j,
              y: i,
            ),
          );
        }
      }
    }

    return Stack(
      children: [
        Container(
          width: boardWidth,
          height: boardWidth,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: tiles,
          ),
        ),
        if (theEnd)
          Container(
            width: boardWidth,
            height: boardWidth,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[500]!.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'The end!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildControlButtons(double boardWidth, BuildContext context) {
    return Container(
      width: boardWidth,
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.undo,
                size: 25,
                color: Colors.white,
              ),
            ),
            onTap: () => context.read<GameBloc>().add(UndoMove()),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(7.5),
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.restart_alt,
                size: 30,
                color: Colors.white,
              ),
            ),
            onTap: () => context.read<GameBloc>().add(RestartGame()),
          ),
        ],
      ),
    );
  }

  Widget _buildScore(int score, String text, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[100],
                ),
          ),
          FittedBox(
            child: Text(
              '$score',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final boardWidth = MediaQuery.of(context).size.width - 40;
    return BlocBuilder<GameBloc, GameState>(
      builder: (ctx, state) => Container(
        alignment: Alignment.center,
        color: const Color(0xfff1ece1),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '2048',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Row(
                  children: [
                    _buildScore(state.score, 'SCORE', context),
                    const SizedBox(width: 10),
                    _buildScore(state.bestScore, 'BEST', context),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Flexible(
                    flex: 4,
                    child: Text.rich(
                      TextSpan(
                        text: 'Join the numbers and get to the ',
                        style: Theme.of(context).textTheme.titleLarge,
                        children: [
                          TextSpan(
                            text: '2048 tile!',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
            _buildControlButtons(boardWidth, context),
            SwipeDetector(
              onSwipeUp: () => ctx.read<GameBloc>().add(MoveUp()),
              onSwipeDown: () => ctx.read<GameBloc>().add(MoveDown()),
              onSwipeLeft: () => ctx.read<GameBloc>().add(MoveRight()),
              onSwipeRight: () => ctx.read<GameBloc>().add(MoveLeft()),
              disable: state is GameEndDefeat,
              child: _buildStage(state.board, boardWidth, state is GameEndDefeat, context),
            ),
          ],
        ),
      ),
    );
  }
}
