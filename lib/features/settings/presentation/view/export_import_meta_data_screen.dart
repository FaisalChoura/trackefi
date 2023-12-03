import 'package:Trackefi/core/domain/helpers/helpers.dart';
import 'package:Trackefi/features/settings/presentation/viewmodel/export_import_meta_data_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExportImportMetaDataScreen extends ConsumerWidget {
  const ExportImportMetaDataScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(exportImportMetaDataViewModelProvider.notifier);

    return Scaffold(
        body: Container(
            padding:
                const EdgeInsets.only(top: 36, left: 24, right: 24, bottom: 36),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      iconSize: 35,
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.chevron_left,
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                  const Text(
                    'Import / export meta data',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView(children: [
                  ListTile(
                      title: const Text('Export meta all data'),
                      onTap: () async {
                        final json = await viewModel.generateJson();
                        final fileCreated =
                            await viewModel.generateFileFromJson(json);
                        if (fileCreated) {
                          TrHelpers.snackBar(context, 'Export file created');
                        }
                      }),
                  ListTile(
                      title: const Text('Import meta data'),
                      onTap: () async {
                        final json = await viewModel.readJsonFile();
                        if (json == null) {
                          TrHelpers.snackBar(context, 'Something went wrong');
                        }
                        final dataImported =
                            await viewModel.createDataFromFile(json!);
                        if (dataImported) {
                          TrHelpers.snackBar(
                              context, 'Data succesfully imported');
                        }
                      }),
                ]),
              ),
            ])));
  }
}
