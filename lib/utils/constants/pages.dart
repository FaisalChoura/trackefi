import 'package:flutter/material.dart';

import '../../screens/categories_screen.dart';
import '../../screens/csv_import_screen.dart';

final pages = <String, WidgetBuilder>{
  'Categories': (_) => const CategoriesScreen(),
  'CSV Import': (_) => const CsvImportScreen(),
};
