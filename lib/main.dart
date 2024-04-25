import 'dart:developer';

import 'package:ai_client/ai_client.dart';
import 'package:bloc/bloc.dart';
import 'package:digital_escape_room/app/app.dart';
import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';
import 'package:game_repository/game_repository.dart';
import 'package:statistics_repository/statistics_repository.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

void main() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  Bloc.observer = const AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  final aiClient = _createAiClient();
  final gameRepository = GameRepository(aiClient);
  final statisticsRepository = StatisticsRepository();
  runApp(App(gameRepository, statisticsRepository));
}

AiClient _createAiClient() {
  const apiKey = bool.hasEnvironment('GOOGLE_GENERATIVE_AI_API_KEY')
      ? String.fromEnvironment('GOOGLE_GENERATIVE_AI_API_KEY')
      : null;
  return apiKey.isNullOrEmpty
      ? const AiClientUnauthenticated()
      : AiClientAuthenticated.withApiKey(apiKey: apiKey!);
}

extension on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }
}
