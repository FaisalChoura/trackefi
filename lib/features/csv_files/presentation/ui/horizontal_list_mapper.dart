import 'package:flutter/material.dart';

class HorizontalListMapper<K, T> extends StatefulWidget {
  final Map<String, K> headerValueMap;
  final List<HorizontalListMapperOption<T>> options;
  final ValueChanged<Map<K, T>> onChanged;
  const HorizontalListMapper({
    Key? key,
    required this.headerValueMap,
    required this.options,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<HorizontalListMapper<K, T>> createState() =>
      _HorizontalListMapperState<K, T>();
}

class _HorizontalListMapperState<K, T>
    extends State<HorizontalListMapper<K, T>> {
  Map<K, T> selectedValues = {};

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
        columnList.add(Column(
          children: [
            Text(header),
            DropdownButton(
                value: selectedValues[mappedHeaderValue],
                items: [
                  for (var option in widget.options)
                    // TODO should not allow duplicate values
                    DropdownMenuItem(
                      value: option.value,
                      child: Text(option.label),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      final tempValues = {...selectedValues};
                      tempValues[mappedHeaderValue] = value;
                      selectedValues = tempValues;

                      widget.onChanged(selectedValues);
                    });
                  }
                })
          ],
        ));
      }
    }
    return columnList;
  }
}

class HorizontalListMapperOption<T> {
  String label;
  T value;
  HorizontalListMapperOption({required this.label, required this.value});
}
