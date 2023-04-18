import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Position {
  final int x;
  final int y;

  Position({required this.x, required this.y});
}

class Tile extends Equatable {
  const Tile({
    required this.number,
    required this.key,
    required this.isNew,
  });
  final Key key;
  final int number;
  final bool isNew;

  @override
  List<Object?> get props => [number];

  Tile copyWith({
    int? number,
    Key? key,
    bool? isNew,
  }) =>
      Tile(
        key: key ?? this.key,
        number: number ?? this.number,
        isNew: isNew ?? this.isNew,
      );

  const Tile.empty(this.key)
      : isNew = false,
        number = 0;
}
