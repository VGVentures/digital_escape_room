part of 'player_creation_form_bloc.dart';

class PlayerCreationFormState extends Equatable {
  const PlayerCreationFormState({
    this.name = const NameInput.pure(),
    this.company = const CompanyInput.pure(),
    this.jobTitle = const JobTitleInput.pure(),
    this.areasOfInterest = const AreasOfInterestInput.pure(),
    this.status = FormzSubmissionStatus.initial,
  });

  final NameInput name;
  final CompanyInput company;
  final JobTitleInput jobTitle;
  final AreasOfInterestInput areasOfInterest;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [
        name,
        company,
        jobTitle,
        areasOfInterest,
        status,
      ];

  PlayerCreationFormState copyWith({
    NameInput? name,
    CompanyInput? company,
    JobTitleInput? jobTitle,
    AreasOfInterestInput? areasOfInterest,
    FormzSubmissionStatus? status,
  }) {
    return PlayerCreationFormState(
      name: name ?? this.name,
      company: company ?? this.company,
      jobTitle: jobTitle ?? this.jobTitle,
      areasOfInterest: areasOfInterest ?? this.areasOfInterest,
      status: status ?? this.status,
    );
  }
}
