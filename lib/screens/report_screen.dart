import 'package:expense_categoriser/services/categoriser.dart';
import 'package:expense_categoriser/services/report_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/categories_provider.dart';
import '../utils/models/category.dart';

class ReportScreen extends ConsumerWidget {
  final ReportService reportService = ReportService();
  ReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Category> categories = ref.watch(categoriesProvider);
    Categoriser categoriser = Categoriser(categories);
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: Column(children: [
        MaterialButton(
            child: const Text('Generate Report'),
            onPressed: () async {
              final categorisedTransactions = await categoriser.categorise();
              reportService.generateReport(categorisedTransactions);
            })
      ]),
    );
  }
}
