import 'package:expense_categoriser/features/csv_files/data/data_module.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/import_settings.dart';
import 'package:expense_categoriser/features/csv_files/presentation/viewmodel/csv_files_viewmodel.dart';
import 'package:expense_categoriser/features/reports/domain/enum/numbering_style.dart';
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
                    await _openImportSettingsDialog(result.files);
                    final csvData = result.files
                        .map((file) => CsvFileData(file, CsvImportSettings()))
                        .toList();
                    ref.read(csvFilesViewModelProvider).importFiles(csvData);
                  }
                },
              ),
            ),
          ],
        ));
  }

  Future<List<CsvFileData>> _openImportSettingsDialog(
      List<PlatformFile> files) async {
    return await showDialog<List<CsvFileData>>(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: CsvImportsSettingsDialog(
                files: files,
              ),
            );
          },
        ) ??
        [];
  }
}

class CsvImportsSettingsDialog extends ConsumerStatefulWidget {
  const CsvImportsSettingsDialog({Key? key, required this.files})
      : super(key: key);

  final List<PlatformFile> files;

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
    final file = widget.files[0];
    return Container(
      child: Form(
        child: Column(children: [
          TextField(
            decoration: const InputDecoration(label: Text('Field Separator')),
            controller: fieldDelimiterController,
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
                  });
                }
              }),
          FutureBuilder(
              future: ref.read(csvFilesViewModelProvider).getHeaderRow(file),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  final headerList = snapshot.data;
                  // TODO create widget to map fields to indexes
                  return Row(
                    children: [for (var title in snapshot.data!) Text(title)],
                  );
                }
                return Container();
              })
        ]),
      ),
    );
  }
}
