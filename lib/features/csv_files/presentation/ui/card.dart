import 'package:expense_categoriser/core/presentation/themes/light_theme.dart';
import 'package:flutter/material.dart';

class TrCard extends StatelessWidget {
  final Widget? header;
  final Widget? body;
  final Widget? footer;
  const TrCard({super.key, this.header, this.body, this.footer});

  // TODO remove this card
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: TColors.grey)),
      child: Column(children: [
        header ?? Container(),
        const SizedBox(
          height: 16,
        ),
        body ?? Container(),
        const SizedBox(
          height: 16,
        ),
        footer ?? Container()
      ]),
    );
  }
}
