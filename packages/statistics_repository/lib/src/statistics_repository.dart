import 'package:statistics_repository/statistics_repository.dart';

class StatisticsRepository {
  StatisticsRepository();

  Statistics statistics = const Statistics();

  void recordPlayerInformation(Player player) {
    statistics = statistics.copyWith(player: player);
  }

  void recordPrompt(String prompt) {
    statistics = statistics.copyWith(prompt: prompt);
  }

  void recordGameEvent(GameEvent event) {
    final allEvents = [...statistics.events, event];
    statistics = statistics.copyWith(events: allEvents);
  }

  void resetStatistics() {
    statistics = const Statistics();
  }
}
