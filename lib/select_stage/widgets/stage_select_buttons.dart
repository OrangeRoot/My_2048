import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/stage_size_cubit.dart';

class StageSelectButtons extends StatelessWidget {
  const StageSelectButtons({
    super.key,
    required this.state,
  });
  final StageSizeState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: state is MinimalStageSize
              ? const SizedBox()
              : IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () => context.read<StageSizeCubit>().decreaseStageSize(),
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                    size: 50,
                    color: Colors.brown,
                  ),
                ),
        ),
        Text(
          '${state.size} x ${state.size}',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.brown),
        ),
        Expanded(
          child: state is MaximalStageSize
              ? const SizedBox()
              : IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () => context.read<StageSizeCubit>().increaseStageSize(),
                  icon: const Icon(
                    Icons.keyboard_arrow_right,
                    size: 50,
                    color: Colors.brown,
                  ),
                ),
        ),
      ],
    );
  }
}
