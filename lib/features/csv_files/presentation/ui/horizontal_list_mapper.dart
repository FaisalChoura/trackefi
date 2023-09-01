import 'package:expense_categoriser/core/presentation/ui/select_field.dart';
import 'package:flutter/material.dart';

class HorizontalListMapper<K, T> extends StatefulWidget {
  final Map<String, K> headerValueMap;
  final List<HorizontalListMapperOption<T>> options;
  final ValueChanged<Map<K, T>> onChanged;
  final Map<K, T>? value;
  const HorizontalListMapper({
    Key? key,
    required this.headerValueMap,
    required this.options,
    required this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  State<HorizontalListMapper<K, T>> createState() =>
      _HorizontalListMapperState<K, T>();
}

class _HorizontalListMapperState<K, T>
    extends State<HorizontalListMapper<K, T>> {
  late Map<K, T> selectedValues;

  @override
  void initState() {
    super.initState();
    selectedValues = widget.value ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: genrateColumns(),
    );
  }

  List<Widget> genrateColumns() {
    final headerValues = widget.headerValueMap.keys;
    final columnList = <Widget>[];

    for (var header in headerValues) {
      final mappedHeaderValue = widget.headerValueMap[header];

      if (mappedHeaderValue != null) {
        columnList.add(Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TrSelectField(
                    label: header,
                    value: selectedValues[mappedHeaderValue],
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text(''),
                      ),
                      for (var option in widget.options)
                        DropdownMenuItem(
                          value: option.value,
                          enabled: _isOptionEnabled(option.value),
                          child: Text(option.label),
                        ),
                    ],
                    onChanged: (value) {
                      if (value == null) {
                        setState(() {
                          selectedValues.remove(mappedHeaderValue);

                          widget.onChanged(selectedValues);
                        });
                        return;
                      }
                      setState(() {
                        final tempValues = {...selectedValues};
                        tempValues[mappedHeaderValue] = value;
                        selectedValues = tempValues;

                        widget.onChanged(selectedValues);
                      });
                    })
              ],
            ),
          ),
        ));
      }
    }
    return columnList;
  }

  bool _isOptionEnabled(T value) {
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
