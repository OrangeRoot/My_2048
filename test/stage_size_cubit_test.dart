import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_2048/select_stage/cubit/stage_size_cubit.dart';

class MockStageSizeCubit extends MockCubit<StageSizeState> implements StageSizeCubit {}

void main() {
  group('StageSizeCubit:', () {
    blocTest(
      'emit StageSizeUpdated(size: 5) when increaseStageSize is called ',
      build: () => StageSizeCubit(),
      act: (bloc) => bloc.increaseStageSize(),
      expect: () => [const StageSizeUpdated(size: 5)],
    );
    blocTest(
      'emit StageSizeUpdated(size: 4) when decreaseStageSize is called and seeded with StageSizeUpdated(size: 5)',
      build: () => StageSizeCubit(),
      seed: () => const StageSizeUpdated(size: 5) as StageSizeState,
      act: (bloc) => bloc.decreaseStageSize(),
      expect: () => [const StageSizeUpdated(size: 4)],
    );
    blocTest(
      'emit MaximalStageSize(size: 7) when increaseStageSize is called and seeded with StageSizeUpdated(size: 6)',
      build: () => StageSizeCubit(),
      seed: () => const StageSizeUpdated(size: 6) as StageSizeState,
      act: (bloc) => bloc.increaseStageSize(),
      expect: () => [const MaximalStageSize(size: 7)],
    );
    blocTest(
      'emit MinimalStageSize(size: 3) when decreaseStageSize is called and seeded with StageSizeUpdated(size: 4)',
      build: () => StageSizeCubit(),
      seed: () => const StageSizeUpdated(size: 4) as StageSizeState,
      act: (bloc) => bloc.decreaseStageSize(),
      expect: () => [const MinimalStageSize(size: 3)],
    );
  });
}
