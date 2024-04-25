part of 'puzzle_overlay_bloc.dart';

sealed class PuzzleOverlayState {}

final class PuzzleOverlayInitial extends PuzzleOverlayState {}

final class PuzzleSolvedSuccess extends PuzzleOverlayState {}

final class PuzzleSolvedFailure extends PuzzleOverlayState {
  PuzzleSolvedFailure(this.answerProvided);
  final String answerProvided;
}
