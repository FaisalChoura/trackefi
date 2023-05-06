import 'package:flutter/material.dart';

import '../../screens/categories_screen.dart';
import '../../screens/csv_import_screen.dart';

final pages = <String, WidgetBuilder>{
  'Categories Page': (_) => const CategoriesScreen(),
  'CSV Import Page': (_) => const CsvImportScreen(),
};
