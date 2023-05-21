import 'package:flutter/material.dart';

import '../features/categories/presentaion/view/categories_screen.dart';
import '../features/csv_files/presentation/view/csv_import_screen.dart';
import '../features/reports/presentation/view/report_screen.dart';

final pages = <String, WidgetBuilder>{
  ScreenRoutes.categories: (_) => const CategoriesScreen(),
  ScreenRoutes.csvImport: (_) => const CsvImportScreen(),
  ScreenRoutes.reports: (_) => const ReportScreen(),
};

class ScreenRoutes {
  static String categories = 'Categories';
  static String csvImport = 'CSV Import';
  static String reports = 'Reports';
}
