import 'dart:async';
import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../settings.dart';

class SaveLanguageSettingUseCase
    implements UseCaseFuture<Failure, bool, Language> {
  SaveLanguageSettingUseCase(this.repository);
  final SettingsRepository repository;

  @override
  FutureOr<Either<Failure, bool>> call(Language params) {
    return repository.saveLanguageSetting(params);
  }
}
