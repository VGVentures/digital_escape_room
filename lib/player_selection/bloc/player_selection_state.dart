part of 'player_selection_bloc.dart';

sealed class PlayerSelectionState extends Equatable {
  const PlayerSelectionState();

  @override
  List<Object> get props => [];
}

final class PlayerSelectionInitial extends PlayerSelectionState {}

final class LoadGameInProgress extends PlayerSelectionState {}

final class LoadGameSuccess extends PlayerSelectionState {
  const LoadGameSuccess(this.challenges);

  final EscapeRoomChallenges challenges;

  @override
  List<Object> get props => [challenges];
}

final class LoadGameFailure extends PlayerSelectionState {}
