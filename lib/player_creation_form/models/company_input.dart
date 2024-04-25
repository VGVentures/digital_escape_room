import 'package:formz/formz.dart';

enum CompanyInputError { empty }

class CompanyInput extends FormzInput<String, CompanyInputError> {
  const CompanyInput.pure() : super.pure('');

  const CompanyInput.dirty({String value = ''}) : super.dirty(value);

  @override
  CompanyInputError? validator(String value) {
    return value.isEmpty ? CompanyInputError.empty : null;
  }
}
