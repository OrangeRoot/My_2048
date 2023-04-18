import 'package:flutter/material.dart';

import '../../play_game/screens/game_page.dart';
import '../cubit/stage_size_cubit.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
    required this.state,
  });
  final StageSizeState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xfff65e3b).withOpacity(0.8),
          padding: const EdgeInsets.all(0),
        ),
        onPressed: () => Navigator.of(context).pushNamed(GamePage.routeName, arguments: state.size),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'PLAY',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Colors.white.withOpacity(0.85)),
            ),
          ],
        ),
      ),
    );
  }
}
