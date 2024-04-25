import 'package:digital_escape_room/l10n/l10n.dart';
import 'package:digital_escape_room/player_selection/player_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:statistics_repository/statistics_repository.dart';

class App extends StatelessWidget {
  const App(this.gameRepository, this.statisticsRepository, {super.key});

  final GameRepository gameRepository;
  final StatisticsRepository statisticsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: gameRepository),
        RepositoryProvider.value(value: statisticsRepository),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: flutterNesTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const PlayerSelectionPage(),
      ),
    );
  }
}
