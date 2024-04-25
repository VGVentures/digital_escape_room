part of 'escape_room_bloc.dart';

sealed class EscapeRoomEvent {
  const EscapeRoomEvent();
}

final class GameStarted extends EscapeRoomEvent {
  const GameStarted({required this.numberOfTicks});
  final int numberOfTicks;
}

final class WrongAnswerSubmitted extends EscapeRoomEvent {
  const WrongAnswerSubmitted({
    required this.puzzle,
    required this.answerProvided,
  });

  final Puzzle puzzle;
  final String answerProvided;

  String get describeGameEvent =>
      'You tried to guess the following puzzle: "${puzzle.question}".\n\n'
      'The answer you provided was "$answerProvided".\n\n'
      'Unfortunately, Gemini determined that it was incorrect.';
}

final class HintRequested extends EscapeRoomEvent {
  const HintRequested(this.puzzle);
  final Puzzle puzzle;

  String get describeGameEvent =>
      'You requested a hint for "${puzzle.question}".\n\n'
      'The hint was ${puzzle.hint}';
}

final class PuzzleSolved extends EscapeRoomEvent {
  const PuzzleSolved(this.puzzle);
  final Puzzle puzzle;

  String get describeGameEvent =>
      'You solved the following puzzle: "${puzzle.question}".\n\n'
      'The answer was "${puzzle.answer}".';
}

class _TimerTicked extends EscapeRoomEvent {
  const _TimerTicked({required this.duration});
  final int duration;
}
