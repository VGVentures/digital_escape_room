import 'package:equatable/equatable.dart';

enum EventType { success, hint, error }

class Statistics extends Equatable {
  const Statistics({
    this.player,
    this.prompt,
    this.events = const [],
  });

  final Player? player;
  final String? prompt;
  final List<GameEvent> events;

  @override
  List<Object?> get props => [player, prompt, events];

  Statistics copyWith({
    Player? player,
    String? prompt,
    List<GameEvent>? events,
    String? email,
  }) {
    return Statistics(
      player: player ?? this.player,
      prompt: prompt ?? this.prompt,
      events: events ?? this.events,
    );
  }

  @override
  String toString() => '$player - $prompt - $events';
}

class Player extends Equatable {
  const Player({
    required this.company,
    required this.jobTitle,
    required this.name,
  });

  final String name;
  final String jobTitle;
  final String company;

  @override
  List<Object?> get props => [name, jobTitle, company];

  @override
  String toString() => 'Player($name, $jobTitle, $company)';
}

class GameEvent extends Equatable {
  const GameEvent({
    required this.timeLeft,
    required this.event,
    required this.type,
  });

  final String event;
  final EventType type;
  final Duration timeLeft;

  @override
  List<Object?> get props => [event, timeLeft];

  @override
  String toString() => 'Event: $event, Time Left: $timeLeft, Type: $type';
}
