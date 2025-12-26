import 'package:formz/formz.dart';
import '../../../../core/core.dart';

enum PasswordValidationError { invalid }

class PasswordFormZ extends FormzInput<String, PasswordValidationError> {
  const PasswordFormZ.pure() : super.pure('');
  const PasswordFormZ.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String? value) {
    return Validators.isValidPassword(value ?? '') == false &&
            value != null &&
            value.isNotEmpty
        ? PasswordValidationError.invalid
        : null;
  }
}
