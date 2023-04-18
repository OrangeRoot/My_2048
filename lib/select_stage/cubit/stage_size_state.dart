part of 'stage_size_cubit.dart';

abstract class StageSizeState extends Equatable {
  const StageSizeState({required this.size});
  final int size;

  @override
  List<Object> get props => [size];
}

class InitialStageSize extends StageSizeState {
  const InitialStageSize() : super(size: 4);
}

class StageSizeUpdated extends StageSizeState {
  const StageSizeUpdated({required super.size});
}

class MaximalStageSize extends StageSizeState {
  const MaximalStageSize({required super.size});
}

class MinimalStageSize extends StageSizeState {
  const MinimalStageSize({required super.size});
}
