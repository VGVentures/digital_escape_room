// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'escape_room_challenges.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EscapeRoomChallenges _$EscapeRoomChallengesFromJson(
  Map<String, dynamic> json,
) =>
    EscapeRoomChallenges(
      firstPuzzle: Puzzle.fromJson(json['firstPuzzle'] as Map<String, dynamic>),
      secondPuzzle:
          Puzzle.fromJson(json['secondPuzzle'] as Map<String, dynamic>),
      thirdPuzzle: Puzzle.fromJson(json['thirdPuzzle'] as Map<String, dynamic>),
    );
