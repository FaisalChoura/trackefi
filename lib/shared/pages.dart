import 'package:flutter/material.dart';

import '../categories/screens/categories_screen.dart';
import '../csv_files/screens/csv_import_screen.dart';
import '../reports/screens/report_screen.dart';

final pages = <String, WidgetBuilder>{
  ScreenRoutes.categories: (_) => const CategoriesScreen(),
  ScreenRoutes.csvImport: (_) => CsvImportScreen(),
  ScreenRoutes.reports: (_) => const ReportScreen(),
};

class ScreenRoutes {
  static String categories = 'Categories';
  static String csvImport = 'CSV Import';
  static String reports = 'Reports';
}
