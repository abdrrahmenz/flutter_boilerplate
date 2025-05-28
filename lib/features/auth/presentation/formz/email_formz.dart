import 'package:formz/formz.dart';
import '../../../../core/core.dart';

enum EmailValidationError { invalid }

class EmailFormZ extends FormzInput<String, EmailValidationError> {
  const EmailFormZ.pure() : super.pure('');
  const EmailFormZ.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String? value) {
    return Validators.isValidEmail(value ?? '') == false &&
            value != null &&
            value.isNotEmpty
        ? EmailValidationError.invalid
        : null;
  }
}
