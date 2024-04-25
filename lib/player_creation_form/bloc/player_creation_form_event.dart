part of 'player_creation_form_bloc.dart';

sealed class PlayerCreationFormEvent extends Equatable {
  const PlayerCreationFormEvent();

  @override
  List<Object> get props => [];
}

final class NameChanged extends PlayerCreationFormEvent {
  const NameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class CompanyChanged extends PlayerCreationFormEvent {
  const CompanyChanged(this.company);

  final String company;

  @override
  List<Object> get props => [company];
}

final class JobTitleChanged extends PlayerCreationFormEvent {
  const JobTitleChanged(this.jobTitle);

  final String jobTitle;

  @override
  List<Object> get props => [jobTitle];
}

final class AreasOfInterestChanged extends PlayerCreationFormEvent {
  const AreasOfInterestChanged(this.areasOfInterest);

  final List<String> areasOfInterest;

  @override
  List<Object> get props => [areasOfInterest];
}
