import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_repository/game_repository.dart';
import 'package:statistics_repository/statistics_repository.dart';

part 'player_selection_event.dart';
part 'player_selection_state.dart';

class PlayerSelectionBloc
    extends Bloc<PlayerSelectionEvent, PlayerSelectionState> {
  PlayerSelectionBloc(
    this._gameRepository,
    this._statisticsRepository,
  ) : super(PlayerSelectionInitial()) {
    on<EnterEscapeRoomPressed>(_onEnterEscapeRoomPressed);
  }

  final GameRepository _gameRepository;
  final StatisticsRepository _statisticsRepository;

  Future<void> _onEnterEscapeRoomPressed(
    EnterEscapeRoomPressed event,
    Emitter<PlayerSelectionState> emit,
  ) async {
    emit(LoadGameInProgress());
    try {
      final (prompt, challenges) = await _gameRepository.loadChallenges(
        playerFullName: event.name,
        playerCompany: event.company,
        playerRoleTitle: event.jobTitle,
        areasOfInterest: event.areasOfInterest,
      );
      _statisticsRepository
        ..recordPlayerInformation(
          Player(
            company: event.company,
            jobTitle: event.jobTitle,
            name: event.name,
          ),
        )
        ..recordPrompt(prompt);
      emit(LoadGameSuccess(challenges));
    } catch (_) {
      emit(LoadGameFailure());
    }
  }
}
