import 'package:Trackefi/core/domain/enums/button_styles.dart';
import 'package:Trackefi/core/presentation/themes/light_theme.dart';
import 'package:flutter/material.dart';

class TrButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;
  final TrButtonStyle style;

  const TrButton(
      {super.key,
      required this.onPressed,
      this.child,
      this.style = TrButtonStyle.primary});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      textColor:
          style == TrButtonStyle.primary ? Colors.white : TColors.mainBlue,
      onPressed: onPressed,
      elevation: 0,
      hoverElevation: 0,
      padding: const EdgeInsets.all(21),
      shape: const RoundedRectangleBorder(
          side: BorderSide(width: 2, color: TColors.mainBlue),
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(10.0), bottom: Radius.circular(10))),
      color: style == TrButtonStyle.primary
          ? TColors.mainBlue
          : Colors.transparent,
      height: 42,
      child: child,
    );
  }
}
