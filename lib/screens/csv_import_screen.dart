import 'package:expense_categoriser/services/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/categoriser.dart';
import '../utils/models/category.dart';

class CsvImportScreen extends ConsumerWidget {
  const CsvImportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Category> categories = ref.watch(categoriesProvider);
    Categoriser categoriser = Categoriser(categories);
    return Scaffold(
      appBar: AppBar(title: const Text('CSV import')),
      body: Center(
        child: MaterialButton(
          child: const Text('load CSV'),
          onPressed: () {
            categoriser.categorise();
          },
        ),
      ),
    );
  }
}
