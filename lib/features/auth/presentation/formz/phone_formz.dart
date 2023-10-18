import 'package:formz/formz.dart';
import '../../../../core/core.dart';

enum PhoneValidationError { invalid }

class PhoneFormZ extends FormzInput<String, PhoneValidationError> {
  const PhoneFormZ.pure() : super.pure('');
  const PhoneFormZ.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneValidationError? validator(String? value) {
    return !Validators.isValidPhoneNumber(value ?? '') &&
            (value ?? '').length < 10 &&
            value != null &&
            value.isNotEmpty
        ? PhoneValidationError.invalid
        : null;
  }
}
