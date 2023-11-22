import 'package:Trackefi/core/domain/extensions/reverse_map_extension.dart';
import 'package:Trackefi/core/presentation/themes/light_theme.dart';
import 'package:Trackefi/core/presentation/ui/button.dart';
import 'package:Trackefi/core/presentation/ui/select_field.dart';
import 'package:Trackefi/core/presentation/ui/text_field.dart';
import 'package:Trackefi/features/csv_files/domain/enum/date_format.dart';
import 'package:Trackefi/features/csv_files/domain/enum/expense_sign.dart';
import 'package:Trackefi/features/csv_files/domain/enum/numbering_style.dart';
import 'package:Trackefi/features/csv_files/domain/model/csv_file_data.dart';
import 'package:Trackefi/features/csv_files/presentation/ui/horizontal_list_mapper.dart';
import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/settings/presentation/viewmodel/import_settings_dialog_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CsvImportsSettingsDialog extends ConsumerStatefulWidget {
  const CsvImportsSettingsDialog({Key? key, required this.fileData})
      : super(key: key);

  final CsvFileData fileData;

  @override
  ConsumerState<CsvImportsSettingsDialog> createState() =>
      _CsvImportsSettingsDialogState();
}

class _CsvImportsSettingsDialogState
    extends ConsumerState<CsvImportsSettingsDialog> {
  NumberingStyle numberingStyle = NumberingStyle.eu;
  DateFormatEnum dateFormat = DateFormatEnum.ddmmyyyy;
  TextEditingController fieldDelimiterController = TextEditingController();
  TextEditingController dateSeparatorController = TextEditingController();
  FieldIndexes fieldIndexes = FieldIndexes();
  ExpenseSignEnum expenseSign = ExpenseSignEnum.negative;
  String selectedCurrencyId = 'USD';
  bool excludeIncome = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final importSettings = widget.fileData.importSettings;

    super.initState();
    fieldDelimiterController.text = importSettings.fieldDelimiter.isEmpty
        ? ','
        : importSettings.fieldDelimiter;
    dateSeparatorController.text = importSettings.dateSeparator.isEmpty
        ? '/'
        : importSettings.dateSeparator;
    numberingStyle = importSettings.numberStyle;
    expenseSign = importSettings.expenseSign;
    dateFormat = importSettings.dateFormat;
    fieldIndexes = importSettings.fieldIndexes;
    selectedCurrencyId = importSettings.currencyId.isEmpty
        ? selectedCurrencyId
        : importSettings.currencyId;

    widget.fileData.importSettings.currencyId = selectedCurrencyId;
    excludeIncome = importSettings.excludeIncome;
  }

  @override
  Widget build(BuildContext context) {
    final currencyList = ref
        .read(importSettingsDialogViewModelProvider.notifier)
        .getCurrencies();
    final fileData = widget.fileData;

    return SizedBox(
      height: 500,
      width: 1300,
      child: Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Import Settings',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: TrTextField(
                          label: 'Field Separator',
                          controller: fieldDelimiterController,
                          maxLength: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                fileData.importSettings.fieldDelimiter = value;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        flex: 1,
                        child: TrTextField(
                          label: 'Date Separator',
                          controller: dateSeparatorController,
                          maxLength: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                fileData.importSettings.dateSeparator = value;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                          flex: 1,
                          child: TrSelectField(
                              label: 'Currency',
                              value: selectedCurrencyId,
                              items: currencyList
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.id),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    selectedCurrencyId = value;
                                    fileData.importSettings.currencyId = value;
                                  });
                                }
                              })),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: TrSelectField(
                              label: 'Numbering Style',
                              value: numberingStyle,
                              items: const [
                                DropdownMenuItem(
                                  value: NumberingStyle.eu,
                                  child: Text('EU'),
                                ),
                                DropdownMenuItem(
                                  value: NumberingStyle.us,
                                  child: Text('US'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    numberingStyle = value;
                                    fileData.importSettings.numberStyle = value;
                                  });
                                }
                              }),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          flex: 1,
                          child: TrSelectField(
                              label: 'Expenses Sign',
                              value: expenseSign,
                              items: const [
                                DropdownMenuItem(
                                  value: ExpenseSignEnum.negative,
                                  child: Text('Negative'),
                                ),
                                DropdownMenuItem(
                                  value: ExpenseSignEnum.positive,
                                  child: Text('Positive'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    expenseSign = value;
                                    fileData.importSettings.expenseSign =
                                        expenseSign;
                                  });
                                }
                              }),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          flex: 1,
                          child: TrSelectField(
                              label: 'Date Format',
                              value: dateFormat,
                              items: const [
                                DropdownMenuItem(
                                  value: DateFormatEnum.ddmmyyyy,
                                  child: Text('DDMMYYYY'),
                                ),
                                DropdownMenuItem(
                                  value: DateFormatEnum.mmddyyyy,
                                  child: Text('MMDDYYYY'),
                                ),
                                DropdownMenuItem(
                                  value: DateFormatEnum.yyyymmdd,
                                  child: Text('YYYYMMDD'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    dateFormat = value;
                                    fileData.importSettings.dateFormat = value;
                                  });
                                }
                              }),
                        ),
                        Flexible(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: excludeIncome,
                                  onChanged: (bool? value) => setState(() {
                                    excludeIncome = value!;
                                    fileData.importSettings.excludeIncome =
                                        value;
                                  }),
                                ),
                                const Text('Exclude Income'),
                              ],
                            ))
                      ]),
                  FutureBuilder(
                      future: ref
                          .read(importSettingsDialogViewModelProvider.notifier)
                          .getHeaderAndFirstRow(fileData),
                      builder: (context, snapshot) {
                        if (snapshot.error != null) {
                          return Text(snapshot.error.toString());
                        }
                        if (snapshot.data != null) {
                          final headerList = snapshot.data!.headerRow;
                          final firstDataRow = snapshot.data!.firstRow;
                          return Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              // TODO add text to explain what this is
                              Table(
                                border: TableBorder.all(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                    bottom: Radius.circular(12),
                                  ),
                                ),
                                columnWidths: const <int, TableColumnWidth>{
                                  0: IntrinsicColumnWidth(),
                                  1: FlexColumnWidth(),
                                  2: FixedColumnWidth(64),
                                },
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                children: <TableRow>[
                                  TableRow(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      color: TColors.grey,
                                    ),
                                    children: <Widget>[
                                      for (var col in headerList)
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              col,
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  TableRow(
                                    children: <Widget>[
                                      for (var col in firstDataRow)
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              col,
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              HorizontalListMapper<int, UsableCsvFields>(
                                headerValueMap: headerList.asReverseMap(),
                                value: fieldIndexes.toMap(),
                                options: [
                                  HorizontalListMapperOption<UsableCsvFields>(
                                      label: 'Description',
                                      value: UsableCsvFields.description),
                                  HorizontalListMapperOption<UsableCsvFields>(
                                      label: 'Date',
                                      value: UsableCsvFields.date),
                                  HorizontalListMapperOption<UsableCsvFields>(
                                      label: 'Amount',
                                      value: UsableCsvFields.amount),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    fieldIndexes = FieldIndexes.fromMap(value);
                                  });
                                },
                              )
                            ],
                          );
                        }
                        return Container();
                      })
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TrButton(
                        child: const Text('Done'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // final importSettings = CsvImportSettings();
                            fileData.importSettings.fieldIndexes = fieldIndexes;
                            // importSettings.fieldDelimiter =
                            //     fieldDelimiterController.text;
                            // importSettings.numberStyle = numberingStyle;
                            // importSettings.dateFormat = dateFormat;
                            // importSettings.dateSeparator =
                            //     dateSeparatorController.text;
                            // importSettings.expenseSign = expenseSign;
                            Navigator.of(context).pop(CsvFileData(
                                fileData.file, fileData.importSettings));
                          }
                        }),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
