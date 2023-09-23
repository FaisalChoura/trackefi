import 'package:Trackefi/core/presentation/ui/accordion.dart';
import 'package:Trackefi/core/presentation/ui/button.dart';
import 'package:Trackefi/core/presentation/ui/select_field.dart';
import 'package:Trackefi/features/reports/domain/model/report_category_snapshot.dart';
import 'package:Trackefi/features/reports/presentation/viewmodel/reports_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final openedPannel = StateProvider<String>((ref) => '');

class EditableCategorisedTransactionsList extends ConsumerStatefulWidget {
  final List<ReportCategorySnapshot> categorySnapshots;
  const EditableCategorisedTransactionsList(
      {super.key, required this.categorySnapshots});

  @override
  ConsumerState<EditableCategorisedTransactionsList> createState() =>
      _EditableCategorisedTransactionsListState();
}

class _EditableCategorisedTransactionsListState
    extends ConsumerState<EditableCategorisedTransactionsList> {
  late List<CategorySnapshotItem> _data;

  @override
  void initState() {
    super.initState();
    _data = generateItems(widget.categorySnapshots);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 900,
      width: 1200,
      child: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 32),
                  child: Text(
                    'Categorised Transactions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 560,
                  child: SingleChildScrollView(child: _buildAccordion()),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                children: [
                  Expanded(
                    child: TrButton(
                      onPressed: () =>
                          Navigator.of(context).pop(widget.categorySnapshots),
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAccordion() {
    return TrAccordion(
      items: _data.map((item) {
        return TrAccordionItem(
            id: item.categorySnapshot.id,
            leading: Text(item.categorySnapshot.name),
            trailing: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text('- ${item.categorySnapshot.totalExpenses}'),
                ),
                Text('+ ${item.categorySnapshot.totalIncome}'),
              ],
            ),
            subItems: item.categorySnapshot.transactions
                .map((transaction) => Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 150,
                              child: Text(transaction.name.toString())),
                          Text(transaction.amount.toString()),
                          Text(transaction.date.toString().split(' ')[0]),
                          SizedBox(
                            width: 200,
                            child: TrSelectField(
                              value: item.categorySnapshot.id,
                              // list all transactions
                              items: widget.categorySnapshots
                                  .map((e) => DropdownMenuItem(
                                      value: e.id, child: Text(e.name)))
                                  .toList(),
                              onChanged: (id) {
                                final movedToCategory = widget.categorySnapshots
                                    .firstWhere(
                                        (category) => category.id == id);

                                final updatedCategorySnapshtList = ref
                                    .read(reportsListViewModel.notifier)
                                    .moveTransactionToCategory(
                                        item.categorySnapshot,
                                        movedToCategory,
                                        transaction,
                                        widget.categorySnapshots);

                                setState(() {
                                  _data =
                                      generateItems(updatedCategorySnapshtList);
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ))
                .toList());
      }).toList(),
    );
  }
}

class CategorySnapshotItem {
  CategorySnapshotItem({
    required this.categorySnapshot,
    this.isExpanded = false,
  });

  ReportCategorySnapshot categorySnapshot;
  bool isExpanded;
}

List<CategorySnapshotItem> generateItems(
    List<ReportCategorySnapshot> categorySnapshots) {
  final numberOfItems = categorySnapshots.length;
  return List<CategorySnapshotItem>.generate(numberOfItems, (int index) {
    return CategorySnapshotItem(
      categorySnapshot: categorySnapshots[index],
    );
  });
}
