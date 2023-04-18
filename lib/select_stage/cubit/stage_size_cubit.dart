import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stage_size_state.dart';

class StageSizeCubit extends Cubit<StageSizeState> {
  StageSizeCubit() : super(const InitialStageSize());
  final int minimalStageSize = 3;
  final int maximalStageSize = 7;

  void increaseStageSize() => state.size + 1 == maximalStageSize
      ? emit(MaximalStageSize(size: state.size + 1))
      : emit(StageSizeUpdated(size: state.size + 1));
  void decreaseStageSize() => state.size - 1 == minimalStageSize
      ? emit(MinimalStageSize(size: state.size - 1))
      : emit(StageSizeUpdated(size: state.size - 1));
}
