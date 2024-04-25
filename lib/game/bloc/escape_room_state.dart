part of 'escape_room_bloc.dart';

class EscapeRoomState extends Equatable {
  const EscapeRoomState({
    required this.ticksLeft,
    required this.wrongAnswers,
    required this.puzzlesSolved,
    required this.remainingHintsAllowed,
    required this.hasPlayerLost,
  });

  factory EscapeRoomState.initial() => EscapeRoomState(
        ticksLeft: escapeRoomTicks,
        wrongAnswers: 0,
        hasPlayerLost: false,
        remainingHintsAllowed: escapeRoomNumberOfHintsAllowed,
        puzzlesSolved: List.empty(),
      );

  final int ticksLeft;
  final int wrongAnswers;
  final int remainingHintsAllowed;
  final bool hasPlayerLost;
  final List<Puzzle> puzzlesSolved;

  Duration get duration => Duration(seconds: ticksLeft);
  bool get hasPlayerWon => puzzlesSolved.length == escapeRoomNumberOfPuzzles;
  bool get canRequestMoreHints => remainingHintsAllowed != 0;

  @override
  List<Object> get props => [
        ticksLeft,
        wrongAnswers,
        hasPlayerLost,
        puzzlesSolved,
        remainingHintsAllowed,
      ];

  @override
  String toString() =>
      'GameState: ticksLeft $ticksLeft, solved: ${puzzlesSolved.length} '
      'wrongLeft: $wrongAnswers, hasLost: $hasPlayerLost, '
      'remainingHints: $remainingHintsAllowed';

  EscapeRoomState copyWith({
    int? ticksLeft,
    int? wrongAnswers,
    int? remainingHintsAllowed,
    bool? hasPlayerLost,
    List<Puzzle>? puzzlesSolved,
  }) {
    return EscapeRoomState(
      ticksLeft: ticksLeft ?? this.ticksLeft,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      hasPlayerLost: hasPlayerLost ?? this.hasPlayerLost,
      puzzlesSolved: puzzlesSolved ?? this.puzzlesSolved,
      remainingHintsAllowed:
          remainingHintsAllowed ?? this.remainingHintsAllowed,
    );
  }
}
