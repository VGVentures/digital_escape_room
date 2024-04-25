import 'package:digital_escape_room/extensions/extensions.dart';
import 'package:digital_escape_room/game/game.dart';
import 'package:digital_escape_room/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';

class HeadsUpDisplay extends StatelessWidget {
  const HeadsUpDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<EscapeRoomBloc, EscapeRoomState>(
      builder: (BuildContext context, EscapeRoomState state) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.hasPlayerLost)
                Text(l10n.gameOver)
              else
                _CountDown(state.duration),
              const SizedBox(height: 20),
              _WrongAnswersAllowed(state.wrongAnswers),
              const SizedBox(height: 20),
              _HintsAllowed(state.remainingHintsAllowed),
              const SizedBox(height: 20),
              _PuzzlesSolved(state.puzzlesSolved.length),
            ],
          ),
        );
      },
    );
  }
}

class _CountDown extends StatelessWidget {
  const _CountDown(this.duration);

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return NesContainer(
      width: double.infinity,
      label: l10n.timeRemaining,
      child: Center(
        child: Text(
          duration.toMinuteAndSecond(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

class _WrongAnswersAllowed extends StatelessWidget {
  const _WrongAnswersAllowed(this.wrongAnswersAllowed);

  final int wrongAnswersAllowed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _HudContainer(
      label: l10n.wrongAnswers,
      content: '$wrongAnswersAllowed / $escapeRoomMaxWrongAnswersAllowed',
    );
  }
}

class _HintsAllowed extends StatelessWidget {
  const _HintsAllowed(this.hintsAllowed);

  final int hintsAllowed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _HudContainer(
      label: l10n.hints,
      content: '$hintsAllowed / $escapeRoomNumberOfHintsAllowed',
    );
  }
}

class _PuzzlesSolved extends StatelessWidget {
  const _PuzzlesSolved(this.puzzlesSolved);

  final int puzzlesSolved;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _HudContainer(
      label: l10n.puzzlesSolved,
      content: '$puzzlesSolved / $escapeRoomNumberOfPuzzles',
    );
  }
}

class _HudContainer extends StatelessWidget {
  const _HudContainer({required this.label, required this.content});

  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return NesContainer(
      label: label,
      width: double.infinity,
      child: Center(
        child: Text(content, style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
