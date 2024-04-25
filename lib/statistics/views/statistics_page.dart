import 'package:digital_escape_room/extensions/extensions.dart';
import 'package:digital_escape_room/l10n/l10n.dart';
import 'package:digital_escape_room/player_selection/player_selection.dart';
import 'package:digital_escape_room/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:statistics_repository/statistics_repository.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage(
    this.statistics, {
    required this.didPlayerWin,
    super.key,
  });

  final Statistics statistics;
  final bool didPlayerWin;

  static Route<void> route(
    Statistics statistics, {
    required bool didPlayerWin,
  }) {
    return NesVerticalCloseTransition.route<void>(
      pageBuilder: (_, __, ___) {
        return BlocProvider(
          create: (context) =>
              StatisticsBloc(context.read<StatisticsRepository>()),
          child: StatisticsPage(statistics, didPlayerWin: didPlayerWin),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<StatisticsBloc, StatisticsState>(
      listener: (context, state) {
        if (state is StatisticsSuccess) {
          _showSuccessSnackbar(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SizedBox(
              width: 700,
              child: SingleChildScrollView(
                child: NesWindow(
                  title: l10n.escapeRoomReport,
                  icon: NesIcons.newFile,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          didPlayerWin ? l10n.congratulations : l10n.gameOver,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20),
                        if (statistics.player != null)
                          Text(l10n.thankYou(statistics.player!.name)),
                        const SizedBox(height: 12),
                        Text(l10n.gameResults),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 500,
                          child: NesTabView(
                            tabs: [
                              NesTabItem(
                                label: l10n.gameStats,
                                child: _GameEvents(statistics.events),
                              ),
                              NesTabItem(
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: _Prompt(statistics.prompt!),
                                ),
                                label: l10n.aiPrompt,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: NesButton(
                            type: NesButtonType.warning,
                            child: Text(l10n.startNewGame),
                            onPressed: () => context
                                .read<StatisticsBloc>()
                                .add(const StatisticsSubmitted()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSuccessSnackbar(BuildContext context) {
    final l10n = context.l10n;
    Navigator.of(context).pushAndRemoveUntil(
      PlayerSelectionPage.route(),
      (_) => false,
    );
    NesSnackbar.show(
      context,
      text: l10n.thankYou(statistics.player!.name),
      type: NesSnackbarType.success,
    );
  }
}

class _GameEvents extends StatelessWidget {
  const _GameEvents(this.events);

  final List<GameEvent> events;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (events.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Center(child: Text(l10n.noEventsRecorded)),
      );
    } else {
      return NesSingleChildScrollView(
        child: Column(
          children: ListTile.divideTiles(
            context: context,
            tiles: events.map<Widget>((event) {
              return ListTile(
                leading: event.type.toIcon(),
                title: Text(event.timeLeft.toMinuteAndSecond()),
                subtitle: Text(event.event),
              );
            }).toList(),
          ).toList(),
        ),
      );
    }
  }
}

class _Prompt extends StatelessWidget {
  const _Prompt(this.prompt);

  final String prompt;

  @override
  Widget build(BuildContext context) {
    return NesSingleChildScrollView(child: Column(children: [Text(prompt)]));
  }
}

extension on EventType {
  NesIcon toIcon() {
    switch (this) {
      case EventType.success:
        return NesIcon(
          iconData: NesIcons.check,
          primaryColor: Colors.green,
        );
      case EventType.hint:
        return NesIcon(
          iconData: NesIcons.letter,
          primaryColor: Colors.amber,
        );
      case EventType.error:
        return NesIcon(
          iconData: NesIcons.yamlFile,
          primaryColor: Colors.redAccent,
        );
    }
  }
}
