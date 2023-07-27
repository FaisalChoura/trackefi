import 'package:flutter/material.dart';

class TrTextField extends StatelessWidget {
  TextEditingController? controller;
  bool autofocus;

  TrTextField({super.key, this.controller, this.autofocus = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autofocus,
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
