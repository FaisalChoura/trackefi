import 'dart:async';

import 'package:expense_categoriser/services/categoriser.dart';
import 'package:expense_categoriser/services/csv_reader_service.dart';
import 'package:expense_categoriser/services/report_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/categories_provider.dart';
import '../services/csv_files_provider.dart';
import '../utils/models/category.dart';
import '../utils/models/report.dart';
import '../utils/models/transaction.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  final ReportService reportService = ReportService();
  final CsvReaderService csvReaderService = CsvReaderService();
  Report? report;

  @override
  Widget build(BuildContext context) {
    List<Category> categories = ref.watch(categoriesProvider);
    final csvFiles = ref.watch(csvFilesProvider);

    Categoriser categoriser = Categoriser(categories);
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: Column(children: [
        MaterialButton(
            child: const Text('Generate Report'),
            onPressed: () async {
              final data = await csvReaderService.convertFilesToCsv(csvFiles);
              final categorisedTransactions =
                  // TODO handle multiple files
                  await categoriser.categorise(data[0]!);

              if (categorisedTransactions['Uncategorised']!.isNotEmpty) {
                await _handleUncategorisedTransactions(categorisedTransactions);
              }

              setState(() {
                report = reportService.generateReport(categorisedTransactions);
              });
            }),
        if (report != null)
          Column(
            children: [
              for (var category in report!.categories)
                Text("${category.name}: ${category.total}")
            ],
          )
      ]),
    );
  }

  Future<Map<String, List<Transaction>>?> _handleUncategorisedTransactions(
      Map<String, List<Transaction>> categorisedTransactions) async {
    return showDialog<Map<String, List<Transaction>>>(
      context: context,
      builder: (BuildContext context) {
        final uncategorisedTransactions =
            categorisedTransactions['Uncategorised'];
        return Dialog(
          child: SizedBox(
            height: 400,
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final categories = ref.watch(categoriesProvider);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      if (uncategorisedTransactions != null)
                        for (var transaction in uncategorisedTransactions)
                          UncategorisedItemRow(
                              transaction: transaction, categories: categories)
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class UncategorisedItemRow extends ConsumerStatefulWidget {
  const UncategorisedItemRow({
    super.key,
    required this.transaction,
    required this.categories,
  });

  final Transaction transaction;
  final List<Category> categories;

  @override
  ConsumerState<UncategorisedItemRow> createState() =>
      _UncategorisedItemRowState();
}

class _UncategorisedItemRowState extends ConsumerState<UncategorisedItemRow> {
  late Category selectedCategory;
  List<SelectableWordItem> selectedWords = [];

  @override
  void initState() {
    selectedCategory = widget.categories[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableWords(
          value: widget.transaction.name,
          onChanged: (values) {
            setState(() {
              selectedWords = values;
            });
          },
        ),
        DropdownButton(
            value: selectedCategory!.id,
            items: widget.categories
                .map(
                  (category) => DropdownMenuItem(
                    value: category.id,
                    child: Text(category.name),
                  ),
                )
                .toList(),
            onChanged: (val) {
              setState(() {
                selectedCategory = widget.categories
                    .where((element) => element.id == val!)
                    .first;
              });
            }),
        Text(widget.transaction.amount.toString()),
        IconButton(
          onPressed: () {
            final addedKeywords = selectedWords
                .map((selectableWord) => selectableWord.keyword.toLowerCase())
                .toList();
            selectedCategory.keywords = [
              ...selectedCategory.keywords,
              ...addedKeywords
            ];
            ref
                .read(categoriesProvider.notifier)
                .updateCategory(selectedCategory);
          },
          icon: const Icon(Icons.check),
        )
      ],
    );
  }
}

class SelectableWords extends StatefulWidget {
  const SelectableWords({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<List<SelectableWordItem>> onChanged;

  @override
  State<SelectableWords> createState() => _SelectableWordsState();
}

class _SelectableWordsState extends State<SelectableWords> {
  Map<int, SelectableWordItem> selectedWordItems = {};
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var item in _getKeywordsFromString(widget.value, ' '))
              MaterialButton(
                onPressed: () => _toggleSelectedWordItem(item),
                color: selectedWordItems[item.id] != null
                    ? Colors.blue
                    : Colors.white,
                child: Text(item.keyword),
              )
          ],
        ),
      ),
    );
  }

  List<SelectableWordItem> _getKeywordsFromString(
      String value, Pattern splitBy) {
    final mappedValues = value.split(splitBy).asMap();
    return mappedValues.keys.map((key) {
      return SelectableWordItem(key, mappedValues[key] ?? '');
    }).toList();
  }

  void _toggleSelectedWordItem(SelectableWordItem item) {
    if (selectedWordItems[item.id] != null) {
      selectedWordItems.remove(item.id);
    } else {
      selectedWordItems[item.id] = item;
    }

    setState(() {
      selectedWordItems = selectedWordItems;

      widget.onChanged(selectedWordItems.values.toList());
    });
  }
}

class SelectableWordItem {
  int id;
  String keyword;
  SelectableWordItem(this.id, this.keyword);
}
