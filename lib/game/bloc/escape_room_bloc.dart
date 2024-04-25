import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:digital_escape_room/game/game.dart' hide Puzzle;
import 'package:equatable/equatable.dart';
import 'package:game_repository/game_repository.dart';
import 'package:statistics_repository/statistics_repository.dart';

part 'escape_room_event.dart';
part 'escape_room_state.dart';

class EscapeRoomBloc extends Bloc<EscapeRoomEvent, EscapeRoomState> {
  EscapeRoomBloc(this._statisticsRepository, {required Ticker ticker})
      : _ticker = ticker,
        super(EscapeRoomState.initial()) {
    on<GameStarted>(_onGameStarted);
    on<PuzzleSolved>(_onPuzzleSolved);
    on<WrongAnswerSubmitted>(_onWrongAnswerSubmitted);
    on<HintRequested>(_onHintRequested);
    on<_TimerTicked>(_onTimerTicked);
  }

  StreamSubscription<int>? _tickerSubscription;
  final StatisticsRepository _statisticsRepository;
  final Ticker _ticker;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onGameStarted(GameStarted event, Emitter<EscapeRoomState> emit) {
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.numberOfTicks)
        .listen((duration) => add(_TimerTicked(duration: duration)));
  }

  void _onPuzzleSolved(PuzzleSolved event, Emitter<EscapeRoomState> emit) {
    final puzzlesSolved = state.puzzlesSolved;
    final puzzleSolved = event.puzzle;
    if (!puzzlesSolved.contains(puzzleSolved)) {
      final newPuzzlesSolved = [...puzzlesSolved, puzzleSolved];
      if (newPuzzlesSolved.length == escapeRoomNumberOfPuzzles) {
        _tickerSubscription?.cancel();
      }
      emit(state.copyWith(puzzlesSolved: newPuzzlesSolved));
      _statisticsRepository.recordGameEvent(
        GameEvent(
          timeLeft: state.duration,
          event: event.describeGameEvent,
          type: EventType.success,
        ),
      );
    }
  }

  void _onWrongAnswerSubmitted(
    WrongAnswerSubmitted event,
    Emitter<EscapeRoomState> emit,
  ) {
    final wrongAnswers = state.wrongAnswers + 1;
    emit(
      state.copyWith(
        hasPlayerLost: wrongAnswers >= escapeRoomMaxWrongAnswersAllowed,
        wrongAnswers: wrongAnswers,
      ),
    );
    _statisticsRepository.recordGameEvent(
      GameEvent(
        timeLeft: state.duration,
        event: event.describeGameEvent,
        type: EventType.error,
      ),
    );
  }

  void _onTimerTicked(_TimerTicked event, Emitter<EscapeRoomState> emit) {
    final hasPlayerLost = state.ticksLeft <= 1 || state.hasPlayerLost;
    emit(
      state.copyWith(
        ticksLeft: state.ticksLeft - 1,
        hasPlayerLost: hasPlayerLost,
      ),
    );
  }

  FutureOr<void> _onHintRequested(
    HintRequested event,
    Emitter<EscapeRoomState> emit,
  ) {
    final hintsRemaning = state.remainingHintsAllowed - 1;
    _statisticsRepository.recordGameEvent(
      GameEvent(
        timeLeft: state.duration,
        event: event.describeGameEvent,
        type: EventType.hint,
      ),
    );
    emit(state.copyWith(remainingHintsAllowed: hintsRemaning));
  }
}
