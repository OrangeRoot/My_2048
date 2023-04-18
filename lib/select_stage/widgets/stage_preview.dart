import 'package:flutter/material.dart';

class StagePreview extends StatelessWidget {
  const StagePreview({super.key, required this.image});
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, left: 40, right: 40, bottom: 20),
      child: image,
    );
  }
}
