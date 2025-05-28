import 'package:formz/formz.dart';
import '../../../../core/core.dart';

enum NameValidationError { invalid }

class NameFormZ extends FormzInput<String, NameValidationError> {
  const NameFormZ.pure() : super.pure('');
  const NameFormZ.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String? value) {
    return Validators.nameValidator(value ?? '') &&
            (value ?? '').length <= 2 &&
            value != null &&
            value.isNotEmpty
        ? NameValidationError.invalid
        : null;
  }
}
