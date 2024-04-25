import 'package:digital_escape_room/game/game.dart';
import 'package:digital_escape_room/l10n/l10n.dart';
import 'package:digital_escape_room/player_creation_form/player_creation_form.dart';
import 'package:digital_escape_room/player_selection/player_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:statistics_repository/statistics_repository.dart';

class PlayerSelectionPage extends StatelessWidget {
  const PlayerSelectionPage({super.key});

  static Route<void> route() {
    return NesFillTransition.route<void>(
      pageBuilder: (_, __, ___) {
        return const PlayerSelectionPage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerSelectionBloc(
        context.read<GameRepository>(),
        context.read<StatisticsRepository>(),
      ),
      child: _PlayerSelectionView(),
    );
  }
}

class _PlayerSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<PlayerSelectionBloc, PlayerSelectionState>(
          listener: (context, state) {
            if (state is LoadGameSuccess) {
              Navigator.of(context)
                  .push(EscapeRoomPage.route(state.challenges));
            }
          },
          builder: (context, state) {
            return switch (state) {
              PlayerSelectionInitial() => const PlayerCreationForm(),
              LoadGameSuccess() => _LoadingGame(),
              LoadGameFailure() => const PlayerCreationForm(),
              LoadGameInProgress() => _LoadingGame(),
            };
          },
        ),
      ),
    );
  }
}

class _LoadingGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: NesContainer(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const NesHourglassLoadingIndicator(),
            const SizedBox(height: 25),
            Text(
              context.l10n.createCustomGame,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
