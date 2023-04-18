import 'package:flutter/material.dart';

class WillPopGame extends StatefulWidget {
  const WillPopGame({super.key, required this.child});
  final Widget child;

  @override
  State<WillPopGame> createState() => _WillPopGameState();
}

class _WillPopGameState extends State<WillPopGame> {
  bool _triedQuitApp = false;

  Future<bool> _onPopGame(BuildContext context) async {
    if (_triedQuitApp) {
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        content: const Text('Click again to quit'),
        onVisible: () {
          _triedQuitApp = true;
          Future.delayed(const Duration(seconds: 2), () => _triedQuitApp = false);
        },
      ),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onPopGame(context),
      child: widget.child,
    );
  }
}
