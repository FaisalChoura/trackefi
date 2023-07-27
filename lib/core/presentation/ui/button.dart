import 'package:expense_categoriser/core/presentation/themes/light_theme.dart';
import 'package:flutter/material.dart';

class TrButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;

  const TrButton({super.key, required this.onPressed, this.child});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 0,
      hoverElevation: 0,
      padding: const EdgeInsets.all(21),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(10.0), bottom: Radius.circular(10))),
      color: TColors.mainGreen,
      child: child,
    );
  }
}
