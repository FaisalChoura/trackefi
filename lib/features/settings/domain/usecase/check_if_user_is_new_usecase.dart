import 'package:Trackefi/features/settings/data/repository/application_settings_repository_impl.dart';
import 'package:Trackefi/features/settings/domain/repository/application_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckIfUserIsNewUseCase {
  final ApplicationSettingsRepository _applicationSettingsRepository;
  CheckIfUserIsNewUseCase(this._applicationSettingsRepository);

  bool execute() {
    return _applicationSettingsRepository.isNewUser();
  }
}

final checkIfUserIsNewUseCaseProvider = Provider((ref) =>
    CheckIfUserIsNewUseCase(ref.watch(applicationSettingsRepositoryProvider)));
