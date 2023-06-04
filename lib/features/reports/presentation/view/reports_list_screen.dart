import 'package:expense_categoriser/features/reports/presentation/viewmodel/reports_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportsListScreen extends StatelessWidget {
  const ReportsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('1'),
      appBar: AppBar(title: const Text('Reports List')),
      body: Consumer(builder: (context, ref, child) {
        final viewModel = ref.watch(reportsListViewModel);
        return Container(
          child: viewModel.maybeWhen(
            data: (data) => ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index].expenses.toString()),
                  );
                }),
            orElse: () => Center(child: CircularProgressIndicator()),
          ),
        );
      }),
    );
  }
}
