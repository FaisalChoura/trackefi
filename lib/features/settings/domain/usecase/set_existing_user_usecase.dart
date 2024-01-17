import 'package:Trackefi/features/settings/data/repository/application_settings_repository_impl.dart';
import 'package:Trackefi/features/settings/domain/repository/application_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SetExistingUseCase {
  final ApplicationSettingsRepository _applicationSettingsRepository;
  SetExistingUseCase(this._applicationSettingsRepository);

  void execute() {
    _applicationSettingsRepository.setExistingUser();
  }
}

final setExistingUseCasePovider = Provider((ref) async =>
    SetExistingUseCase(await ref.watch(applicationSettingsRepositoryProvider)));
