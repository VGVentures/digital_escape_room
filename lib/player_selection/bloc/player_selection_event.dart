part of 'player_selection_bloc.dart';

sealed class PlayerSelectionEvent extends Equatable {
  const PlayerSelectionEvent();

  @override
  List<Object> get props => [];
}

class EnterEscapeRoomPressed extends PlayerSelectionEvent {
  const EnterEscapeRoomPressed({
    required this.name,
    required this.company,
    required this.jobTitle,
    required this.areasOfInterest,
  });

  final String name;
  final String company;
  final String jobTitle;
  final List<String> areasOfInterest;

  @override
  List<Object> get props => [name, company, jobTitle, areasOfInterest];
}
