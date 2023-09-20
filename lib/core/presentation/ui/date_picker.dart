import 'package:expense_categoriser/core/presentation/ui/text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrDateField extends StatefulWidget {
  final Function(DateTime) onSaved;
  final String? label;
  final String? initialValue;
  final String? Function(String?)? validator;

  const TrDateField({
    super.key,
    required this.onSaved,
    this.label,
    this.initialValue,
    this.validator,
  });

  @override
  _TrDateFieldState createState() => _TrDateFieldState();
}

class _TrDateFieldState extends State<TrDateField> {
  final TextEditingController _dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      _dateController.text = widget.initialValue!;
      selectedDate = DateFormat('d/m/yyyy').parse(widget.initialValue!);
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1900, 8),
          lastDate: DateTime(2100),
          builder: (context, child) => Container(
            child: child,
          ),
        ) ??
        DateTime.now();
    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
        widget.onSaved(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: TrTextField(
            label: widget.label,
            controller: _dateController,
            validator: widget.validator,
          ),
        ),
      ),
    );
  }
}
