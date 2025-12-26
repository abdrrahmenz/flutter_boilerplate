import 'dart:async';

import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../settings.dart';

class SetDoneOnboardingUseCase
    implements UseCaseFuture<Failure, bool, NoParams> {
  const SetDoneOnboardingUseCase(this.repository);

  final SettingsRepository repository;

  @override
  FutureOr<Either<Failure, bool>> call(NoParams params) {
    return repository.setDoneOnboarding();
  }
}
