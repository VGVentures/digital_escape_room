import 'package:formz/formz.dart';

enum JobTitleInputError { empty }

class JobTitleInput extends FormzInput<String, JobTitleInputError> {
  const JobTitleInput.pure() : super.pure('');

  const JobTitleInput.dirty({String value = ''}) : super.dirty(value);

  @override
  JobTitleInputError? validator(String value) {
    return value.isEmpty ? JobTitleInputError.empty : null;
  }
}
