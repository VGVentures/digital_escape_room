import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_repository/game_repository.dart';

part 'puzzle_overlay_event.dart';
part 'puzzle_overlay_state.dart';

class PuzzleOverlayBloc extends Bloc<PuzzleOverlayEvent, PuzzleOverlayState> {
  PuzzleOverlayBloc(this.puzzle) : super(PuzzleOverlayInitial()) {
    on<PuzzleOverlayAnswerSelected>(_onAnswerSelected);
  }

  final Puzzle puzzle;

  void _onAnswerSelected(
    PuzzleOverlayAnswerSelected event,
    Emitter<PuzzleOverlayState> emit,
  ) {
    final answerSelected = event.answerSelected;
    emit(
      answerSelected == puzzle.answer
          ? PuzzleSolvedSuccess()
          : PuzzleSolvedFailure(answerSelected),
    );
  }
}
