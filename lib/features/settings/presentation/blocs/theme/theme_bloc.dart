import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../app/config.dart';
import '../../../../../core/core.dart';
import '../../../settings.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({
    required this.getThemeSetting,
    required this.saveThemeSetting,
  }) : super(const ThemeState(AppConfig.defaultTheme)) {
    on<ThemeStarted>(_onThemeStarted);
    on<ThemeChanged>(_onThemeChanged);
  }

  final GetThemeSettingUseCase getThemeSetting;
  final SaveThemeSettingUseCase saveThemeSetting;

  Future<void> _onThemeStarted(ThemeStarted event, Emitter<ThemeState> emit) async {
    try {
      final savedData = await getThemeSetting(const NoParams());

      emit(
        savedData.fold(
          (failure) => state,
          ThemeState.new,
        ),
      );
    } catch (exception, stackTrace) {
      exception.recordError(
        RecordErrorParams(exception: exception, stackTrace: stackTrace),
      );
    }
  }

  Future<void> _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) async {
    try {
      final result = await saveThemeSetting(event.theme);

      if (result.isRight()) {
        add(const ThemeStarted());
      }
    } catch (exception, stackTrace) {
      exception.recordError(
        RecordErrorParams(exception: exception, stackTrace: stackTrace),
      );
    }
  }
}
