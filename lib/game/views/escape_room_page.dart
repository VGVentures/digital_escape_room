import 'package:digital_escape_room/game/game.dart' hide Puzzle;
import 'package:digital_escape_room/hud/hud.dart';
import 'package:digital_escape_room/puzzle_overlay/puzzle_overlay.dart';
import 'package:digital_escape_room/statistics/statistics.dart';
import 'package:flame/game.dart' hide Route;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:statistics_repository/statistics_repository.dart';

class EscapeRoomPage extends StatelessWidget {
  const EscapeRoomPage({required this.challenges, super.key});

  final EscapeRoomChallenges challenges;

  static Route<void> route(EscapeRoomChallenges challenges) {
    return NesVerticalCloseTransition.route<void>(
      pageBuilder: (context, __, ___) {
        return BlocProvider(
          create: (_) => EscapeRoomBloc(
            context.read<StatisticsRepository>(),
            ticker: const Ticker(),
          )..add(const GameStarted(numberOfTicks: escapeRoomTicks)),
          child: EscapeRoomPage(challenges: challenges),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final game = EscapeRoomGame();
    return BlocListener<EscapeRoomBloc, EscapeRoomState>(
      listener: (context, state) {
        if (state.hasPlayerLost || state.hasPlayerWon) {
          final statistics = context.read<StatisticsRepository>().statistics;
          Navigator.of(context).pushAndRemoveUntil(
            StatisticsPage.route(statistics, didPlayerWin: state.hasPlayerWon),
            (_) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: gameBackgroundColor,
        body: Row(
          children: [
            Expanded(
              flex: 4,
              child: GameWidget(
                game: kDebugMode ? EscapeRoomGame() : game,
                overlayBuilderMap: {
                  firstPuzzleOverlay: (
                    BuildContext context,
                    EscapeRoomGame game,
                  ) {
                    return PuzzleOverlayDialog(
                      puzzle: challenges.firstPuzzle,
                      overlay: firstPuzzleOverlay,
                      game: game,
                    );
                  },
                  secondPuzzleOverlay: (
                    BuildContext context,
                    EscapeRoomGame game,
                  ) {
                    return PuzzleOverlayDialog(
                      puzzle: challenges.secondPuzzle,
                      overlay: secondPuzzleOverlay,
                      game: game,
                    );
                  },
                  thirdPuzzleOverlay: (
                    BuildContext context,
                    EscapeRoomGame game,
                  ) {
                    return PuzzleOverlayDialog(
                      puzzle: challenges.thirdPuzzle,
                      overlay: thirdPuzzleOverlay,
                      game: game,
                    );
                  },
                },
              ),
            ),
            Theme(
              data: flutterNesTheme(
                brightness: Brightness.dark,
                nesContainerTheme: NesContainerTheme(
                  backgroundColor: gameBackgroundColor,
                  borderColor: Colors.white,
                  labelTextStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
              child: const Expanded(
                child: HeadsUpDisplay(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
