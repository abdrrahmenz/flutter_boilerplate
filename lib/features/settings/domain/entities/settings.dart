import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../app/config.dart';
import '../../../../core/core.dart';

part 'settings.g.dart';

@JsonSerializable(includeIfNull: false)
class Settings extends Equatable {
  const Settings({
    required this.language,
    required this.theme,
  });

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  @JsonKey(name: 'language')
  final Language? language;

  @JsonKey(
    unknownEnumValue: AppConfig.defaultTheme,
    defaultValue: AppConfig.defaultTheme,
  )
  final AppTheme? theme;

  Settings copyWith({
    Language? language,
    AppTheme? theme,
  }) {
    return Settings(
      language: language ?? this.language,
      theme: theme ?? this.theme,
    );
  }

  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  @override
  List<Object?> get props => [language, theme];
}
