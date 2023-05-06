import 'package:expense_categoriser/screens/categories_screen.dart';
import 'package:flutter/material.dart';

import 'app_menu.dart';

class Layout extends StatelessWidget {
  const Layout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 240, child: AppMenu()),
        Container(width: 0.5, color: Colors.black),
        const Expanded(child: CategoriesScreen())
      ],
    );
  }
}
