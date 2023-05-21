import 'package:expense_categoriser/features/reports/presentation/ui/selectable_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/uncategories_row_data.dart';
import '../../domain/model/selectable_word_item.dart';
import '../../domain/model/transaction.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableWords(
          value: widget.transaction.name,
          onChanged: (values) {
            setState(() {
              selectedWords = values;
            });
            widget.onChanged(_onChangeData());
          },
        ),
        DropdownButton(
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
        Text(widget.transaction.amount.toString()),
      ],
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
