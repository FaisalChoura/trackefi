import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/models/categories/category.dart';

class CategoryKeywordField extends ConsumerStatefulWidget {
  final Category category;
  final ValueChanged<String> onChange;
  const CategoryKeywordField(
      {Key? key, required this.category, required this.onChange})
      : super(key: key);

  @override
  ConsumerState<CategoryKeywordField> createState() =>
      CategoryKeywordFieldState();
}

class CategoryKeywordFieldState extends ConsumerState<CategoryKeywordField> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(_handleChanges);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 240,
          child: TextField(
            controller: controller,
          ),
        ),
      ],
    );
  }

  _handleChanges() {
    final text = controller.text;
    if (text.isNotEmpty && text.substring(text.length - 1) == ',') {
      final addedCategory = text.substring(0, text.length - 1);
      widget.onChange(addedCategory);
      controller.clear();
    }
  }
}
