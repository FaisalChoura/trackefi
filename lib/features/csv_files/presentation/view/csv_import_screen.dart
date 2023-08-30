import 'package:expense_categoriser/core/domain/enums/button_styles.dart';
import 'package:expense_categoriser/core/domain/extensions/async_value_error_extension.dart';
import 'package:expense_categoriser/core/domain/extensions/reverse_map_extension.dart';
import 'package:expense_categoriser/core/presentation/themes/light_theme.dart';
import 'package:expense_categoriser/core/presentation/ui/button.dart';
import 'package:expense_categoriser/core/presentation/ui/select_field.dart';
import 'package:expense_categoriser/core/presentation/ui/text_field.dart';
import 'package:expense_categoriser/features/csv_files/data/data_module.dart';
import 'package:expense_categoriser/features/csv_files/domain/enum/date_format.dart';
import 'package:expense_categoriser/features/csv_files/domain/enum/expense_sign.dart';
import 'package:expense_categoriser/features/csv_files/domain/enum/numbering_style.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/import_settings.dart';
import 'package:expense_categoriser/features/csv_files/presentation/ui/card.dart';
import 'package:expense_categoriser/features/csv_files/presentation/ui/horizontal_list_mapper.dart';
import 'package:expense_categoriser/features/csv_files/presentation/viewmodel/csv_files_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CsvImportScreen extends ConsumerStatefulWidget {
  const CsvImportScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CsvImportScreen> createState() => _CsvImportScreenState();
}

class _CsvImportScreenState extends ConsumerState<CsvImportScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(
      csvFilesViewModelProvider,
      (_, state) => state.showDialogOnError(context),
    );

    final csvFilesData = ref.watch(csvFilesStoreProvider);
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 36, left: 24, right: 24, bottom: 24),
        child: Wrap(
          direction: Axis.vertical,
          children: [
            const Text(
              'CSV Files',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            for (var fileData in csvFilesData)
              Padding(
                padding: const EdgeInsets.only(right: 8, top: 16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                  ),
                  child: TrCard(
                    header: Row(
                      children: [
                        const Icon(Icons.file_present),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          fileData.file.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    footer: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TrButton(
                                style: TrButtonStyle.secondary,
                                onPressed: () => ref
                                    .read(csvFilesViewModelProvider.notifier)
                                    .removeFile(fileData),
                                child: const Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'Remove',
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TrButton(
                                style: TrButtonStyle.secondary,
                                onPressed: () => _updateFile(fileData),
                                child: const Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'Edit Settings',
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            // MaterialButton(
            //     child: Text(fileData.file.name),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _loadFile(),
        child: const Icon(Icons.upload_file_outlined),
      ),
    );
  }

  void _loadFile() async {
    FilePickerResult? result;
    result = await ref.read(csvFilesViewModelProvider.notifier).getFiles();
    if (result != null) {
      final csvData = await _openImportSettingsDialog(result.files
          .map((file) => CsvFileData(file, CsvImportSettings()))
          .toList());
      ref.read(csvFilesViewModelProvider.notifier).importFiles(csvData);
    }
  }

  void _updateFile(CsvFileData fileData) async {
    final csvData = await _openImportSettingsDialog([fileData]);
    ref.read(csvFilesViewModelProvider.notifier).updateFile(csvData[0]);
  }

  Future<List<CsvFileData>> _openImportSettingsDialog(
      List<CsvFileData> filesData) async {
    return await showDialog<List<CsvFileData>>(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: CsvImportsSettingsDialog(
                filesData: filesData,
              ),
            );
          },
        ) ??
        [];
  }
}

class CsvImportsSettingsDialog extends ConsumerStatefulWidget {
  const CsvImportsSettingsDialog({Key? key, required this.filesData})
      : super(key: key);

  final List<CsvFileData> filesData;

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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final importSettings = widget.filesData[0].importSettings;

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
  }

  @override
  Widget build(BuildContext context) {
    final fileData = widget.filesData[0];

    return Container(
      height: 500,
      width: 500,
      padding: const EdgeInsets.all(24.0),
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
                        )
                      ]),
                  FutureBuilder(
                      future: ref
                          .read(csvFilesViewModelProvider.notifier)
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
                                            child: Text(col),
                                          ),
                                        ),
                                    ],
                                  ),
                                  TableRow(
                                    children: <Widget>[
                                      for (var col in firstDataRow)
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(col),
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
                                value: fileData.importSettings.fieldIndexes
                                    .toMap(),
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
                                  fieldIndexes = FieldIndexes.fromMap(value);
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
                            final importSettings = CsvImportSettings();
                            importSettings.fieldIndexes = fieldIndexes;
                            importSettings.fieldDelimiter =
                                fieldDelimiterController.text;
                            importSettings.numberStyle = numberingStyle;
                            importSettings.dateFormat = dateFormat;
                            importSettings.dateSeparator =
                                dateSeparatorController.text;
                            importSettings.expenseSign = expenseSign;
                            Navigator.of(context).pop(
                                [CsvFileData(fileData.file, importSettings)]);
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

// TODO extract this

