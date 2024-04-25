import 'package:bloc/bloc.dart';
import 'package:digital_escape_room/player_creation_form/models/models.dart';
import 'package:digital_escape_room/player_creation_form/player_creation_form.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'player_creation_form_event.dart';
part 'player_creation_form_state.dart';

class PlayerCreationFormBloc
    extends Bloc<PlayerCreationFormEvent, PlayerCreationFormState> {
  PlayerCreationFormBloc() : super(const PlayerCreationFormState()) {
    on<NameChanged>(_onNameChanged);
    on<JobTitleChanged>(_onJobTitleChanged);
    on<CompanyChanged>(_onCompanyChanged);
    on<AreasOfInterestChanged>(_onAreasOfInterestChanged);
  }

  void _onNameChanged(
    NameChanged event,
    Emitter<PlayerCreationFormState> emit,
  ) {
    final name = NameInput.dirty(value: event.name);
    final status = Formz.validate([
      name,
      state.company,
      state.jobTitle,
      state.areasOfInterest,
    ]);
    emit(
      state.copyWith(
        name: name,
        status: status
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.failure,
      ),
    );
  }

  void _onJobTitleChanged(
    JobTitleChanged event,
    Emitter<PlayerCreationFormState> emit,
  ) {
    final jobTitle = JobTitleInput.dirty(value: event.jobTitle);
    final status = Formz.validate([
      jobTitle,
      state.name,
      state.company,
      state.areasOfInterest,
    ]);
    emit(
      state.copyWith(
        jobTitle: jobTitle,
        status: status
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.failure,
      ),
    );
  }

  void _onCompanyChanged(
    CompanyChanged event,
    Emitter<PlayerCreationFormState> emit,
  ) {
    final company = CompanyInput.dirty(value: event.company);
    final status = Formz.validate([
      state.name,
      state.jobTitle,
      company,
      state.areasOfInterest,
    ]);
    emit(
      state.copyWith(
        company: company,
        status: status
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.failure,
      ),
    );
  }

  void _onAreasOfInterestChanged(
    AreasOfInterestChanged event,
    Emitter<PlayerCreationFormState> emit,
  ) {
    final areasOfInterest = AreasOfInterestInput.dirty(event.areasOfInterest);
    final status = Formz.validate([
      state.name,
      state.jobTitle,
      state.company,
      areasOfInterest,
    ]);
    emit(
      state.copyWith(
        areasOfInterest: areasOfInterest,
        status: status
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.failure,
      ),
    );
  }
}
