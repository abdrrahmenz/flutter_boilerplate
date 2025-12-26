import 'package:dartz/dartz.dart';

import '../core.dart';

class CaptureErrorUseCase
    implements UseCaseFuture<Failure, bool, CaptureErrorParams> {
  CaptureErrorUseCase();

  // final FirebaseCrashlytics firebaseCrashlytics;

  @override
  Future<Either<Failure, bool>> call(CaptureErrorParams params) async {
    try {
      // await Sentry.captureException(
      //   params.exception,
      //   stackTrace: params.stackTrace,
      // );

      // await firebaseCrashlytics.recordError(
      //   params.exception,
      //   params.stackTrace as StackTrace?,
      // );

      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

class CaptureErrorParams {
  CaptureErrorParams(this.exception, this.stackTrace);

  final Object exception;
  final dynamic stackTrace;
}
