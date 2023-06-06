import 'package:expense_categoriser/features/reports/data/data_module.dart';
import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:expense_categoriser/features/reports/presentation/ui/report_breakdown.dart';
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
        // TODO clean up duplicate lists here
        final reportsList = ref.watch(reportsListStoreProvider);
        final viewModel = ref.watch(reportsListViewModel);
        return Container(
          child: viewModel.maybeWhen(
            data: (data) => ListView.builder(
                itemCount: reportsList.length,
                itemBuilder: (context, index) {
                  final report = reportsList[index];
                  return ListTile(
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Report: ${report.id}'),
                          Text(report.createdAt.toUtc().toString())
                        ]),
                    // TODO sort out routing for side menu
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ReportBreakdownScreen(report: report))),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => ref
                          .read(reportsListViewModel.notifier)
                          .removeReport(report.id),
                    ),
                  );
                }),
            orElse: () => Center(child: CircularProgressIndicator()),
          ),
        );
      }),
    );
  }
}

class ReportBreakdownScreen extends StatelessWidget {
  const ReportBreakdownScreen({super.key, required this.report});
  final Report report;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Report: ${report.id}')),
      body: Center(child: ReportBreakdown(report: report)),
    );
  }
}
