import 'package:Trackefi/features/settings/data/database/application_settings_database.dart';
import 'package:Trackefi/features/settings/domain/repository/application_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApplicationSettingsRepositoryImpl
    implements ApplicationSettingsRepository {
  final ApplicationSettingsDatabase _database;
  ApplicationSettingsRepositoryImpl(this._database);

  @override
  bool isNewUser() {
    return _database.isNewUser();
  }

  @override
  void setExistingUser() {
    return _database.setExistingUser();
  }
}

final applicationSettingsRepositoryProvider =
    Provider<ApplicationSettingsRepository>((ref) =>
        ApplicationSettingsRepositoryImpl(
            ref.watch(applicationSettingsDatabaseProvider)));
