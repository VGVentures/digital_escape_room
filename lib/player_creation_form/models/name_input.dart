import 'package:formz/formz.dart';

enum NameInputError { empty }

class NameInput extends FormzInput<String, NameInputError> {
  const NameInput.pure() : super.pure('');

  const NameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  NameInputError? validator(String value) {
    return value.isEmpty ? NameInputError.empty : null;
  }
}
