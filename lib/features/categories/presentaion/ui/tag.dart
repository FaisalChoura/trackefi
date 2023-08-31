import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String title;
  final VoidCallback onClose;
  final Color? color;
  const Tag(
      {super.key, required this.title, required this.onClose, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(
            width: 4,
          ),
          InkWell(
            onTap: onClose,
            child: const Icon(
              Icons.close,
              size: 14,
            ),
          )
        ],
      ),
    );
  }
}
