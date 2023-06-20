import 'package:expense_categoriser/features/csv_files/data/data_module.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/import_settings.dart';
import 'package:expense_categoriser/features/csv_files/presentation/ui/horizontal_list_mapper.dart';
import 'package:expense_categoriser/features/csv_files/presentation/viewmodel/csv_files_viewmodel.dart';
import 'package:expense_categoriser/features/reports/domain/enum/numbering_style.dart';
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
    final csvFilesData = ref.watch(csvFilesStoreProvider);
    return Scaffold(
        appBar: AppBar(title: const Text('CSV import')),
        body: Column(
          children: [
            for (var fileData in csvFilesData)
              MaterialButton(
                  child: Text(fileData.file.name),
                  onPressed: () =>
                      ref.read(csvFilesViewModelProvider).removeFile(fileData)),
            Center(
              child: MaterialButton(
                child: const Text('load CSV'),
                onPressed: () async {
                  final result =
                      await ref.read(csvFilesViewModelProvider).getFiles();
                  if (result != null) {
                    final csvData = await _openImportSettingsDialog(result.files
                        // TODO handle what happens when different csv separators are added and how we show the initial horizontal list
                        .map((file) => CsvFileData(file, CsvImportSettings()))
                        .toList());
                    ref.read(csvFilesViewModelProvider).importFiles(csvData);
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
  TextEditingController fieldDelimiterController = TextEditingController();
  TextEditingController endOfLineContrller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FieldIndexes fieldIndexes = FieldIndexes();
    final fileData = widget.filesData[0];
    // TODO clean up how form is handled and submited
    return Container(
      child: Form(
        child: Column(children: [
          TextField(
            decoration: const InputDecoration(label: Text('Field Separator')),
            controller: fieldDelimiterController,
            maxLength: 1,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  fileData.importSettings.fieldDelimiter = value;
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
          FutureBuilder(
              future:
                  ref.read(csvFilesViewModelProvider).getHeaderRow(fileData),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  final headerList = snapshot.data;
                  return HorizontalListMapper<int, UsableCsvFields>(
                    headerValueMap: headerList!.asReverseMap(),
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
                  );
                }
                return Container();
              }),
          MaterialButton(
              child: Text('Done'),
              onPressed: () {
                // TODO related to form clean up
                final importSettings = CsvImportSettings();
                importSettings.fieldIndexes = fieldIndexes;
                importSettings.fieldDelimiter = fieldDelimiterController.text;
                importSettings.numberStyle = numberingStyle;
                Navigator.of(context)
                    .pop([CsvFileData(fileData.file, importSettings)]);
              })
        ]),
      ),
    );
  }
}

// TODO extract this
extension ReverseMap on List<String> {
  Map<String, int> asReverseMap() {
    Map<String, int> map = {};
    for (var i = 0; i < length; i++) {
      map[this[i]] = i;
    }
    return map;
  }
}
