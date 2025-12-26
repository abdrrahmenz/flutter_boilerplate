import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../settings.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc({
    required this.getLanguageSetting,
    required this.saveLanguageSetting,
    required this.getSupportedLanguage,
  }) : super(const LanguageState(null, [])) {
    on<LanguageStarted>(_onLanguageStarted);
    on<LanguageChanged>(_onLanguageChanged);
  }

  final GetLanguageSettingUseCase getLanguageSetting;
  final SaveLanguageSettingUseCase saveLanguageSetting;
  final GetSupportedLanguageUseCase getSupportedLanguage;

  Future<void> _onLanguageStarted(
    LanguageStarted event,
    Emitter<LanguageState> emit,
  ) async {
    try {
      final savedData = await getLanguageSetting(const NoParams());
      final languages = await _getSupportedLanguages();

      emit(state.copyWith(supportedLanguages: languages));

      emit(
        savedData.fold(
          (failure) => state,
          (data) => state.copyWith(
            language: data,
            supportedLanguages: languages,
          ),
        ),
      );
    } catch (exception, stackTrace) {
      exception.recordError(
        RecordErrorParams(exception: exception, stackTrace: stackTrace),
      );
    }
  }

  Future<void> _onLanguageChanged(
    LanguageChanged event,
    Emitter<LanguageState> emit,
  ) async {
    try {
      final result = await saveLanguageSetting(event.language);

      if (result.isRight()) {
        add(const LanguageStarted());
      }
    } catch (exception, stackTrace) {
      exception.recordError(
        RecordErrorParams(exception: exception, stackTrace: stackTrace),
      );
    }
  }

  Future<List<Language>> _getSupportedLanguages() async {
    final result = await getSupportedLanguage(
      SupportedLanguageParams(
        locales: AppLocalizations.supportedLocales,
        referenceLanguages: LanguagesData.data,
      ),
    );

    return result.getOrElse(() => []);
  }
}
