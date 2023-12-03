import 'package:Trackefi/core/presentation/ui/button.dart';
import 'package:Trackefi/features/reports/domain/model/report.dart';
import 'package:Trackefi/features/reports/presentation/ui/report_breakdown.dart';
import 'package:Trackefi/features/reports/presentation/viewmodel/reports_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportBreakdownScreen extends ConsumerWidget {
  const ReportBreakdownScreen({super.key, required this.report});
  final Report report;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    iconSize: 35,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.chevron_left,
                    )),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Report: ${report.id}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SingleChildScrollView(
                child: Column(
              children: [
                ReportBreakdown(report: report),
                report.id < 0
                    ? TrButton(
                        child: const Text('Save Report'),
                        onPressed: () => ref
                            .read(reportsListViewModel.notifier)
                            .putReport(report),
                      )
                    : Container()
              ],
            )),
          ],
        ),
      ),
    );
  }
}
