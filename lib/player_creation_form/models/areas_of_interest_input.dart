import 'package:formz/formz.dart';

enum AreasOfInterestInputError { lessThanThreeSelection }

class AreasOfInterestInput
    extends FormzInput<List<String>, AreasOfInterestInputError> {
  const AreasOfInterestInput.pure() : super.pure(const []);

  const AreasOfInterestInput.dirty(super.value) : super.dirty();

  @override
  AreasOfInterestInputError? validator(List<String> value) {
    return value.length < 3
        ? AreasOfInterestInputError.lessThanThreeSelection
        : null;
  }
}
