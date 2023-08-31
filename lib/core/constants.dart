import 'package:expense_categoriser/features/reports/presentation/view/reports_list_screen.dart';
import 'package:flutter/material.dart';

import '../features/categories/presentaion/view/categories_screen.dart';
import '../features/csv_files/presentation/view/csv_import_screen.dart';

final pages = <String, WidgetBuilder>{
  ScreenRoutes.categories: (_) => CategoriesScreen(),
  ScreenRoutes.csvImport: (_) => const CsvImportScreen(),
  ScreenRoutes.reports: (_) => const ReportsListScreen(),
};

class ScreenRoutes {
  static String categories = 'Categories';
  static String csvImport = 'CSV Import';
  static String reports = 'Reports';
}
