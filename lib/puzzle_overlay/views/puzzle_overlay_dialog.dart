import 'package:digital_escape_room/game/game.dart' hide Puzzle;
import 'package:digital_escape_room/l10n/l10n.dart';
import 'package:digital_escape_room/puzzle_overlay/puzzle_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:nes_ui/nes_ui.dart';

class PuzzleOverlayDialog extends StatelessWidget {
  const PuzzleOverlayDialog({
    required this.puzzle,
    required this.overlay,
    required this.game,
    super.key,
  });

  final Puzzle puzzle;
  final EscapeRoomGame game;
  final String overlay;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PuzzleOverlayBloc(puzzle),
      child: PuzzleOverlay(puzzle: puzzle, overlay: overlay, game: game),
    );
  }
}

class PuzzleOverlay extends StatelessWidget {
  const PuzzleOverlay({
    required this.puzzle,
    required this.overlay,
    required this.game,
    super.key,
  });

  final Puzzle puzzle;
  final EscapeRoomGame game;
  final String overlay;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<PuzzleOverlayBloc, PuzzleOverlayState>(
      listener: (context, state) {
        if (state is PuzzleSolvedSuccess) {
          game.overlays.remove(overlay);
          context.read<EscapeRoomBloc>().add(PuzzleSolved(puzzle));
        } else if (state is PuzzleSolvedFailure) {
          context.read<EscapeRoomBloc>().add(
                WrongAnswerSubmitted(
                  puzzle: puzzle,
                  answerProvided: state.answerProvided,
                ),
              );
          NesDialog.show<void>(
            context: context,
            builder: (_) => Text(l10n.wrongAnswer),
          );
        }
      },
      child: BlocBuilder<EscapeRoomBloc, EscapeRoomState>(
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: NesWindow(
                width: 640,
                height: 640,
                onClose: () => game.overlays.remove(overlay),
                title: l10n.puzzleTime,
                child: SizedBox(
                  width: 620,
                  height: 590,
                  child: NesSingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            puzzle.question,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...List.generate(
                          puzzle.options.length,
                          (index) => ListTile(
                            title: Text(puzzle.options[index]),
                            leading: NesIcon(iconData: NesIcons.thinArrowRight),
                            onTap: () {
                              context.read<PuzzleOverlayBloc>().add(
                                    PuzzleOverlayAnswerSelected(
                                      puzzle.options[index],
                                    ),
                                  );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        NesButton.text(
                          type: NesButtonType.warning,
                          text: l10n.wouldYouLikeAHint,
                          onPressed: state.canRequestMoreHints
                              ? () {
                                  context
                                      .read<EscapeRoomBloc>()
                                      .add(HintRequested(puzzle));
                                  NesDialog.show<void>(
                                    context: context,
                                    builder: (_) => Text(puzzle.hint),
                                  );
                                }
                              : null,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
