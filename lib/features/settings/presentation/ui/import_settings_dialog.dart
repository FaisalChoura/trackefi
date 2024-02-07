import 'package:Trackefi/core/domain/errors/exceptions.dart';
import 'package:Trackefi/core/presentation/themes/light_theme.dart';
import 'package:Trackefi/core/presentation/ui/button.dart';
import 'package:Trackefi/core/presentation/ui/dialog.dart';
import 'package:Trackefi/core/presentation/ui/select_field.dart';
import 'package:Trackefi/core/presentation/ui/text_field.dart';
import 'package:Trackefi/features/csv_files/domain/enum/date_format.dart';
import 'package:Trackefi/features/csv_files/domain/enum/expense_sign.dart';
import 'package:Trackefi/features/csv_files/domain/enum/numbering_style.dart';
import 'package:Trackefi/features/csv_files/presentation/ui/horizontal_list_mapper.dart';
import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/settings/presentation/viewmodel/import_settings_dialog_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CsvImportsSettingsDialog extends ConsumerStatefulWidget {
  const CsvImportsSettingsDialog({
    Key? key,
    required this.importSettings,
    this.importedFileEditing = true,
  }) : super(key: key);

  final CsvImportSettings importSettings;
  final bool importedFileEditing;

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
  TextEditingController nameController = TextEditingController();
  FieldIndexes fieldIndexes = FieldIndexes();
  ExpenseSignEnum expenseSign = ExpenseSignEnum.negative;
  String selectedCurrencyId = 'USD';
  bool excludeIncome = false;
  final _formKey = GlobalKey<FormState>();
  late CsvImportSettings importSettings;
  bool isNewImportSettings = false;
  List<CsvImportSettings> importSettingsList = [];
  bool shouldSaveSettings = false;

  @override
  void initState() {
    super.initState();
    importSettings = widget.importSettings;

    _updateFormValues(importSettings);
    if (isNewImportSettings) {
      importSettingsList.add(importSettings);
    }
  }

  void _updateFormValues(CsvImportSettings importSettings) {
    nameController.text = importSettings.name;

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

    widget.importSettings.currencyId = selectedCurrencyId;
    excludeIncome = importSettings.excludeIncome;
    isNewImportSettings = importSettings.id < 0;
    shouldSaveSettings = importSettings.shouldSaveSettings;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(importSettingsDialogViewModelProvider.notifier);

    final currencyList = viewModel.getCurrencies();
    List<String> headerList = [];
    List<String> firstDataRow = [];
    try {
      headerList = importSettings.firstTwoLinesOfFile[0]
          .split(importSettings.fieldDelimiter);
      firstDataRow = importSettings.firstTwoLinesOfFile[1]
          .split(importSettings.fieldDelimiter);

      if (headerList.length < firstDataRow.length) {
        throw ('Corrupt file');
      }
    } catch (e) {
      Navigator.of(context).pop();
      // TODO throw error here using new approach
    }

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
                  if (widget.importedFileEditing)
                    FutureBuilder(
                      future: viewModel.getImportSettings(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        }
                        final List<CsvImportSettings>
                            fetchedImportSettingsList = [
                          ...importSettingsList,
                          ...(snapshot.data ?? [])
                        ];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: TrSelectField(
                                    label: 'Saved Import Settings',
                                    disabled: snapshot.data!.isEmpty,
                                    value: importSettings.id,
                                    items: fetchedImportSettingsList
                                        .map(
                                          (setting) => DropdownMenuItem(
                                            value: setting.id,
                                            child: Text(setting.name),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        final selectedValue =
                                            fetchedImportSettingsList
                                                .where((element) =>
                                                    element.id == value)
                                                .toList()[0];
                                        setState(() {
                                          _updateFormValues(selectedValue);
                                          importSettings = selectedValue;
                                        });
                                      }
                                    }),
                              ),
                            ],
                          ),
                        );
                      },
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
                                importSettings.fieldDelimiter = value;
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
                                importSettings.dateSeparator = value;
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
                                    importSettings.currencyId = value;
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
                                    importSettings.numberStyle = value;
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
                                    importSettings.expenseSign = expenseSign;
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
                                    importSettings.dateFormat = value;
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
                                    importSettings.excludeIncome = value;
                                  }),
                                ),
                                const Text('Exclude Income'),
                              ],
                            ))
                      ]),
                  Column(
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
                                      style: const TextStyle(fontSize: 12),
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
                                      style: const TextStyle(fontSize: 12),
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
                      HorizontalListMapper(
                        value: fieldIndexes.toMap(),
                        headers: headerList,
                        onChanged: (value) {
                          setState(() {
                            fieldIndexes = FieldIndexes.fromMap(value);
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: TrButton(
                        child: const Text('Done'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            importSettings.fieldIndexes = fieldIndexes;
                            if (shouldSaveSettings ||
                                !widget.importedFileEditing) {
                              viewModel.putImportSettings(importSettings);
                            }

                            Navigator.of(context).pop(importSettings);
                          }
                        }),
                  ),
                  if (widget.importedFileEditing)
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: shouldSaveSettings,
                              onChanged: (bool? value) => setState(() {
                                shouldSaveSettings = value!;
                                importSettings.shouldSaveSettings =
                                    shouldSaveSettings;
                              }),
                            ),
                            const Text('Save settings'),
                          ],
                        ),
                      ],
                    ),
                  if (shouldSaveSettings || !widget.importedFileEditing)
                    Container(
                      width: 200,
                      padding: EdgeInsets.only(left: 8),
                      child: TrTextField(
                        label: 'Insert setting name',
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              importSettings.name = value;
                            });
                          }
                        },
                      ),
                    ),
                ],
              )
            ]),
      ),
    );
  }
}

Future<CsvImportSettings> openImportSettingsDialog(
    BuildContext context, CsvImportSettings importSettings,
    [bool importedFileEditing = true]) async {
  return await showTrDialog(
      context,
      CsvImportsSettingsDialog(
        importSettings: importSettings,
        importedFileEditing: importedFileEditing,
      ));
}
