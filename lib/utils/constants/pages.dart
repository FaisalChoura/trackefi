import 'package:flutter/material.dart';

import '../../screens/categories_screen.dart';
import '../../screens/csv_import_screen.dart';

final pages = <String, WidgetBuilder>{
  ScreenRoutes.categories: (_) => const CategoriesScreen(),
  ScreenRoutes.csvImport: (_) => const CsvImportScreen(),
};

class ScreenRoutes {
  static String categories = 'Categories';
  static String csvImport = 'CSV Import';
  static String reports = 'Reports';
}
