import 'package:my_2048/helpers/will_pop_game.dart';
import 'package:my_2048/select_stage/cubit/stage_size_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'select_stage_layout.dart';

class SelectStagePage extends StatelessWidget {
  const SelectStagePage({super.key});
  static const routeName = 'select-stage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StageSizeCubit>(
      create: (context) => StageSizeCubit(),
      child: const SafeArea(
        child: WillPopGame(
          child: Scaffold(
            backgroundColor: Color(0xfff1ece1),
            body: SelectStageLayout(),
          ),
        ),
      ),
    );
  }
}
