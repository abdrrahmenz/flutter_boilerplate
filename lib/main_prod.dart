import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'app/app.dart';
import 'app/flavor.dart';
import 'app/locator.dart';
import 'core/core.dart';

Future<void> main() async {
  F.flavor = .prod;

  runZonedGuarded(
        () async {
      WidgetsFlutterBinding.ensureInitialized();

      await setupLocator();

      Bloc.observer = AppBlocObserver();

      return runApp(const App());
    },
        (error, stackTrace) {
      GetIt.I<CaptureErrorUseCase>().call(
        CaptureErrorParams(error, stackTrace),
      );
      log(
        error.toString(),
        name: 'LOG',
        stackTrace: stackTrace,
      );
    },
  );
}
