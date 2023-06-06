import 'package:expense_categoriser/features/csv_files/data/data_module.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/import_settings.dart';
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
                    // await _openImportSettingsDialog(result.files);
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

  Future<void> _openImportSettingsDialog(List<PlatformFile> files) async {
    await showDialog<List<CsvFileData>>(
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

class CsvImportsSettingsDialog extends StatefulWidget {
  const CsvImportsSettingsDialog({Key? key, required this.files})
      : super(key: key);

  final List<PlatformFile> files;

  @override
  State<CsvImportsSettingsDialog> createState() =>
      _CsvImportsSettingsDialogState();
}

class _CsvImportsSettingsDialogState extends State<CsvImportsSettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
