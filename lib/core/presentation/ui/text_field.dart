import 'package:flutter/material.dart';

class TrTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool autofocus;
  final String? label;
  final int? maxLength;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const TrTextField(
      {super.key,
      this.controller,
      this.autofocus = false,
      this.label,
      this.maxLength,
      this.validator,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      maxLength: maxLength,
      validator: validator,
      decoration: InputDecoration(
        label: label != null ? Text(label!) : null,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
