part of 'puzzle_overlay_bloc.dart';

sealed class PuzzleOverlayEvent extends Equatable {
  const PuzzleOverlayEvent();

  @override
  List<Object> get props => [];
}

final class PuzzleOverlayAnswerSelected extends PuzzleOverlayEvent {
  const PuzzleOverlayAnswerSelected(this.answerSelected);

  final String answerSelected;

  @override
  List<Object> get props => [answerSelected];
}
