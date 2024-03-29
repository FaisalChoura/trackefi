import 'package:Trackefi/core/domain/enums/button_styles.dart';
import 'package:Trackefi/core/domain/extensions/async_value_error_extension.dart';
import 'package:Trackefi/core/presentation/ui/button.dart';
import 'package:Trackefi/features/csv_files/data/data_module.dart';
import 'package:Trackefi/features/csv_files/domain/domain_module.dart';
import 'package:Trackefi/features/csv_files/domain/model/csv_file_data.dart';
import 'package:Trackefi/features/csv_files/presentation/ui/card.dart';
import 'package:Trackefi/features/csv_files/presentation/viewmodel/csv_files_viewmodel.dart';
import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/settings/presentation/ui/import_settings_dialog.dart';
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
            Row(
              children: [
                for (var fileData in csvFilesData)
                  Padding(
                    padding: const EdgeInsets.only(right: 8, top: 16),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 160,
                      ),
                      child: TrCard(
                        header: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              children: [
                                const Icon(Icons.file_present),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  fileData.file.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => ref
                                  .read(csvFilesViewModelProvider.notifier)
                                  .removeFile(fileData),
                            )
                          ],
                        ),
                        footer: Row(
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
                        ),
                      ),
                    ),
                  )
              ],
            )
            // MaterialButton(
            //     child: Text(fileData.file.name),
          ],
        ),
      ),
      floatingActionButton: TrButton(
          onPressed: () => _loadFile(),
          child: const Wrap(
            children: [
              Icon(Icons.upload_file_outlined),
              SizedBox(
                width: 8,
              ),
              Text('Import'),
            ],
          )),
    );
  }

  void _loadFile() async {
    final files = await ref.read(csvFilesViewModelProvider.notifier).getFiles();
    if (files.isNotEmpty) {
      List<CsvFileData> csvDataList = [];
      for (var i = 0; i < files.length; i++) {
        final file = files[i];
        final firstTwoLines =
            await ref.read(getFirstTwoLinesOfFileUseCase).execute(file);
        CsvImportSettings importSettings = CsvImportSettings();
        importSettings.firstTwoLinesOfFile = firstTwoLines;

        importSettings =
            await openImportSettingsDialog(context, importSettings);
        importSettings.fileName = file.name;

        csvDataList.add(CsvFileData(file, importSettings));
      }
      ref.read(csvFilesViewModelProvider.notifier).importFiles(csvDataList);
    }
  }

  void _updateFile(CsvFileData fileData) async {
    final importSettings =
        await openImportSettingsDialog(context, fileData.importSettings);
    ref
        .read(csvFilesViewModelProvider.notifier)
        .updateFile(CsvFileData(fileData.file, importSettings));
  }
}
