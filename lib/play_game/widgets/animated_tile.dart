import 'package:my_2048/play_game/models/tile.dart';
import 'package:flutter/material.dart';

class AnimatedTile extends StatefulWidget {
  final double tileSize;
  final Tile tileData;
  final int x;
  final int y;

  const AnimatedTile({
    super.key,
    required this.tileSize,
    required this.tileData,
    required this.x,
    required this.y,
  });

  @override
  State<AnimatedTile> createState() => _AnimatedTileState();
}

class _AnimatedTileState extends State<AnimatedTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _sizeAnimation = Tween<double>(begin: 0, end: widget.tileSize).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.8,
          1,
          curve: Curves.ease,
        ),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get tileColor {
    switch (widget.tileData.number) {
      case 2:
        return const Color(0xffeee4da);
      case 4:
        return const Color(0xffede0c8);
      case 8:
        return const Color(0xfff2b179);
      case 16:
        return const Color(0xfff59563);
      case 32:
        return const Color(0xfff67c5f);
      case 64:
        return const Color(0xfff65e3b);
      case 128:
        return const Color(0xffedcf72);
      case 256:
        return const Color(0xffedcc61);
      case 512:
        return const Color(0xffedc850);
      case 1024:
        return const Color(0xfff2b179);
      case 2048:
        return const Color(0xffedc53f);
      default:
        return const Color(0xffedc22e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sizeAnimation,
      child: Center(
        child: FittedBox(
          child: Text(
            widget.tileData.number.toString(),
            style: TextStyle(
              fontSize: widget.tileSize / 2,
              fontWeight: FontWeight.bold,
              color: widget.tileData.number > 4 ? Colors.white : Colors.grey[600],
            ),
          ),
        ),
      ),
      builder: (context, child) => AnimatedPositioned(
        duration: Duration(milliseconds: widget.tileData.isNew ? 0 : 250),
        curve: Curves.easeInOut,
        top: widget.y * widget.tileSize,
        left: widget.x * widget.tileSize,
        child: Container(
          padding: const EdgeInsets.all(3),
          height: widget.tileSize,
          width: widget.tileSize,
          child: Center(
            child: Container(
              width: _sizeAnimation.value,
              height: _sizeAnimation.value,
              decoration: BoxDecoration(
                color: tileColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: child!,
            ),
          ),
        ),
      ),
    );
  }
}
