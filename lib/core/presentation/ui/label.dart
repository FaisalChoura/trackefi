import 'package:flutter/material.dart';

class TrLabel extends StatelessWidget {
  final Widget child;
  final Color color;
  const TrLabel({super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: child);
  }
}
