import 'package:Trackefi/core/presentation/ui/select_field.dart';
import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:flutter/material.dart';

class HorizontalListMapper extends StatefulWidget {
  final ValueChanged<Map<int, UsableCsvFields>> onChanged;
  final Map<int, UsableCsvFields>? value;
  final List<String> headers;
  const HorizontalListMapper({
    Key? key,
    required this.onChanged,
    required this.headers,
    this.value,
  }) : super(key: key);

  @override
  State<HorizontalListMapper> createState() => _HorizontalListMapperState();
}

class _HorizontalListMapperState extends State<HorizontalListMapper> {
  late Map<int, UsableCsvFields> selectedValues;
  bool internalChange = false;
  @override
  void initState() {
    selectedValues = widget.value ?? {};
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HorizontalListMapper oldWidget) {
    if (internalChange) {
      internalChange = false;
    } else {
      selectedValues = widget.value ?? {};
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: genrateColumns(),
    );
  }

  List<Widget> genrateColumns() {
    final columnList = <Widget>[];
    final options = [
      HorizontalListMapperOption<UsableCsvFields>(
          label: 'Description', value: UsableCsvFields.description),
      HorizontalListMapperOption<UsableCsvFields>(
          label: 'Date', value: UsableCsvFields.date),
      HorizontalListMapperOption<UsableCsvFields>(
          label: 'Amount', value: UsableCsvFields.amount),
    ];

    for (var i = 0; i < widget.headers.length; i++) {
      final header = widget.headers[i];

      columnList.add(Flexible(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TrSelectField(
                  label: header,
                  value: selectedValues[i],
                  items: [
                    const DropdownMenuItem(
                      value: UsableCsvFields.none,
                      child: Text(''),
                    ),
                    for (var option in options)
                      DropdownMenuItem(
                        value: option.value,
                        enabled: _isOptionEnabled(option.value),
                        child: Text(option.label),
                      ),
                  ],
                  onChanged: (value) {
                    if (value == null) {
                      setState(() {
                        selectedValues[i] = UsableCsvFields.none;

                        widget.onChanged(selectedValues);
                      });
                      return;
                    }
                    setState(() {
                      final tempValues = {...selectedValues};
                      tempValues[i] = value;
                      selectedValues = tempValues;
                      internalChange = true;

                      widget.onChanged(selectedValues);
                    });
                  })
            ],
          ),
        ),
      ));
    }
    return columnList;
  }

  bool _isOptionEnabled(UsableCsvFields value) {
    final selectedValuesKeys = selectedValues.keys.toList();
    for (var key in selectedValuesKeys) {
      if (selectedValues[key] == value) {
        return false;
      }
    }
    return true;
  }
}

class HorizontalListMapperOption<T> {
  String label;
  T value;
  HorizontalListMapperOption({required this.label, required this.value});
}
