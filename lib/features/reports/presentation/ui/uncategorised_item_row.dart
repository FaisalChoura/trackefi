import 'package:expense_categoriser/core/presentation/ui/select_field.dart';
import 'package:expense_categoriser/features/reports/presentation/ui/selectable_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/report_category_snapshot.dart';
import '../../domain/model/uncategories_row_data.dart';
import '../../domain/model/selectable_word_item.dart';
import '../../../categories/domain/model/category.dart';

class UncategorisedItemRow extends ConsumerStatefulWidget {
  const UncategorisedItemRow(
      {super.key,
      required this.transaction,
      required this.categories,
      required this.onChanged});

  final Transaction transaction;
  final List<Category> categories;
  final ValueChanged<UncategorisedRowData> onChanged;

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 3,
            child: SelectableWords(
              value: widget.transaction.name,
              onChanged: (values) {
                setState(() {
                  selectedWords = values;
                });
                widget.onChanged(_onChangeData());
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: TrSelectField(
                value: selectedCategory.id,
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
                  widget.onChanged(_onChangeData());
                }),
          ),
        ],
      ),
    );
  }

  UncategorisedRowData _onChangeData() {
    return UncategorisedRowData(
        selectedCategory,
        selectedWords
            .map((selectableWordItem) =>
                selectableWordItem.keyword.toLowerCase())
            .toList());
  }
}
