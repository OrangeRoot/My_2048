import 'package:my_2048/select_stage/cubit/stage_size_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/stage_preview.dart';
import '../widgets/stage_select_buttons.dart';
import '../widgets/play_button.dart';

class SelectStageLayout extends StatefulWidget {
  const SelectStageLayout({super.key});

  @override
  State<SelectStageLayout> createState() => _SelectStageLayoutState();
}

class _SelectStageLayoutState extends State<SelectStageLayout> {
  final List<Image> images = [];

  @override
  void initState() {
    super.initState();
    for (var i = 3; i <= 7; i++) {
      images.add(Image.asset('assets/images/${i}x$i.jpg'));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var i = 0; i <= 4; i++) {
      precacheImage(images[i].image, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StageSizeCubit, StageSizeState>(
      builder: (ctx, state) {
        return Column(
          children: [
            StagePreview(image: images[state.size - 3]),
            StageSelectButtons(state: state),
            PlayButton(state: state),
          ],
        );
      },
    );
  }
}
