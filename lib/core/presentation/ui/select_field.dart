import 'package:flutter/material.dart';

class TrSelectField extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final Function(dynamic)? onChanged;
  final dynamic value;
  final String? Function(String?)? validator;
  final String? label;
  final bool disabled;

  const TrSelectField({
    super.key,
    this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.label,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: value,
      items: items,
      onChanged: disabled ? null : onChanged,
      decoration: InputDecoration(
        isDense: true,
        label: label != null ? Text(label!) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
