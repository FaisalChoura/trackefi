import 'package:flutter/material.dart';

class TrDialog extends StatelessWidget {
  final Widget child;
  const TrDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: child,
      ),
    );
  }
}

Future<T?> showTrDialog<T>(BuildContext context, Widget child) {
  return showDialog<T>(
      context: context,
      builder: (BuildContext context) {
        return TrDialog(
          child: child,
        );
      });
}
