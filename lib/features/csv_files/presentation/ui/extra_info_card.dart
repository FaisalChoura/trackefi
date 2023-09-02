import 'package:expense_categoriser/core/presentation/ui/card.dart';
import 'package:flutter/material.dart';

class TrExtraInfoCard extends StatelessWidget {
  const TrExtraInfoCard(
      {super.key,
      required this.title,
      required this.child,
      required this.onButtonClick});

  final String title;
  final Widget child;
  final VoidCallback onButtonClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        width: 400,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(
                  onPressed: onButtonClick, child: const Text('View all'))
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          TrCard(height: 180, child: child)
        ]));
  }
}
