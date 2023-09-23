import 'package:expense_categoriser/core/presentation/ui/card.dart';
import 'package:flutter/material.dart';

class TrExtraInfoCard extends StatelessWidget {
  const TrExtraInfoCard(
      {super.key,
      required this.title,
      required this.child,
      this.onButtonClick});

  final String title;
  final Widget child;
  final VoidCallback? onButtonClick;

  @override
  Widget build(BuildContext context) {
    final text = onButtonClick != null ? 'View all' : '';
    return SizedBox(
        height: 250,
        width: 420,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(onPressed: onButtonClick, child: Text(text))
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          TrCard(height: 180, child: child)
        ]));
  }
}
