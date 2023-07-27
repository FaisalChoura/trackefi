import 'package:expense_categoriser/core/presentation/ui/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/model/category.dart';

class CategoryKeywordField extends ConsumerStatefulWidget {
  final Category category;
  final ValueChanged<String> onChange;
  late final TextEditingController? controller;

  CategoryKeywordField(
      {super.key,
      required this.category,
      required this.onChange,
      this.controller}) {
    controller ??= TextEditingController();
  }
  @override
  ConsumerState<CategoryKeywordField> createState() =>
      CategoryKeywordFieldState();
}

class CategoryKeywordFieldState extends ConsumerState<CategoryKeywordField> {
  @override
  void initState() {
    super.initState();
    widget.controller!.addListener(_handleChanges);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: 240,
            child: TrTextField(
              controller: widget.controller,
            )),
      ],
    );
  }

  _handleChanges() {
    final text = widget.controller!.text;
    if (text.isNotEmpty && text.substring(text.length - 1) == ',') {
      final addedCategory = text.substring(0, text.length - 1);
      widget.onChange(addedCategory);
      widget.controller!.clear();
    }
  }
}
