import 'package:expense_categoriser/core/domain/extensions/async_value_error_extension.dart';
import 'package:expense_categoriser/core/domain/extensions/reverse_map_extension.dart';
import 'package:expense_categoriser/features/csv_files/data/data_module.dart';
import 'package:expense_categoriser/features/csv_files/domain/enum/date_format.dart';
import 'package:expense_categoriser/features/csv_files/domain/enum/expense_sign.dart';
import 'package:expense_categoriser/features/csv_files/domain/enum/numbering_style.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/import_settings.dart';
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
        appBar: AppBar(title: const Text('CSV import')),
        body: Column(
          children: [
            for (var fileData in csvFilesData)
              MaterialButton(
                  child: Text(fileData.file.name),
                  onPressed: () => ref
                      .read(csvFilesViewModelProvider.notifier)
                      .removeFile(fileData)),
            Center(
              child: MaterialButton(
                // TODO edit import settings after loading CSV
                child: const Text('load CSV'),
                onPressed: () async {
                  FilePickerResult? result;
                  result = await ref
                      .read(csvFilesViewModelProvider.notifier)
                      .getFiles();
                  if (result != null) {
                    final csvData = await _openImportSettingsDialog(result.files
                        .map((file) => CsvFileData(file, CsvImportSettings()))
                        .toList());
                    ref
                        .read(csvFilesViewModelProvider.notifier)
                        .importFiles(csvData);
                  }
                },
              ),
            ),
          ],
        ));
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
    super.initState();
    fieldDelimiterController.text = ',';
    dateSeparatorController.text = '/';
  }

  @override
  Widget build(BuildContext context) {
    final fileData = widget.filesData[0];
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          decoration: const InputDecoration(label: Text('Field Separator')),
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
        TextFormField(
          decoration: const InputDecoration(label: Text('Date Separator')),
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
        DropdownButton(
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
        DropdownButton(
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
                  fileData.importSettings.expenseSign = expenseSign;
                });
              }
            }),
        DropdownButton(
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
                    Row(
                      children: [for (var col in firstDataRow) Text("$col |")],
                    ),
                    HorizontalListMapper<int, UsableCsvFields>(
                      headerValueMap: headerList.asReverseMap(),
                      options: [
                        HorizontalListMapperOption<UsableCsvFields>(
                            label: 'Description',
                            value: UsableCsvFields.description),
                        HorizontalListMapperOption<UsableCsvFields>(
                            label: 'Date', value: UsableCsvFields.date),
                        HorizontalListMapperOption<UsableCsvFields>(
                            label: 'Amount', value: UsableCsvFields.amount),
                      ],
                      onChanged: (value) {
                        fieldIndexes = FieldIndexes.fromMap(value);
                      },
                    )
                  ],
                );
              }
              return Container();
            }),
        MaterialButton(
            child: const Text('Done'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final importSettings = CsvImportSettings();
                importSettings.fieldIndexes = fieldIndexes;
                importSettings.fieldDelimiter = fieldDelimiterController.text;
                importSettings.numberStyle = numberingStyle;
                importSettings.dateFormat = dateFormat;
                importSettings.dateSeparator = dateSeparatorController.text;
                importSettings.expenseSign = expenseSign;
                Navigator.of(context)
                    .pop([CsvFileData(fileData.file, importSettings)]);
              }
            })
      ]),
    );
  }
}

// TODO extract this

