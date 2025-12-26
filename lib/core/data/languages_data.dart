import '../core.dart';
import 'raw/languages.dart';

class LanguagesData {
  static List<Language> data = _dataFromMap();

  static List<Language> _dataFromMap() =>
      languagesRawData.map(Language.fromJson).toList();
}
