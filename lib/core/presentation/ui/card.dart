import 'package:Trackefi/core/presentation/themes/light_theme.dart';
import 'package:flutter/material.dart';

class TrCard extends StatelessWidget {
  const TrCard({super.key, required this.child, this.height});

  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: TColors.grey),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
