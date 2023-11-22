import 'package:Trackefi/core/data/database/database_manager.dart';
import 'package:Trackefi/features/settings/data/database/import_settings_database.dart';
import 'package:Trackefi/features/settings/data/repository/import_settings_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final importSettingsDatabaseProvider = Provider<ImportSettingsDatabase>(
    (_) => ImportSettingsDatabase(DBManager.isntance.isar));

final reportsRepositoryProvider = Provider<ImportSettingsRepositoryImpl>(
    (ref) => ImportSettingsRepositoryImpl(
        ref.watch(importSettingsDatabaseProvider)));
