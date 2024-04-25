import 'package:ai_client/ai_client.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'escape_room_challenges.g.dart';

@JsonSerializable(createFactory: true, createToJson: false)
class EscapeRoomChallenges extends Equatable {
  const EscapeRoomChallenges({
    required this.firstPuzzle,
    required this.secondPuzzle,
    required this.thirdPuzzle,
  });

  factory EscapeRoomChallenges.fromJson(Map<String, dynamic> json) =>
      _$EscapeRoomChallengesFromJson(json);

  @JsonKey(name: 'firstPuzzle')
  final Puzzle firstPuzzle;
  @JsonKey(name: 'secondPuzzle')
  final Puzzle secondPuzzle;
  @JsonKey(name: 'thirdPuzzle')
  final Puzzle thirdPuzzle;

  @override
  List<Object> get props => [firstPuzzle, secondPuzzle, thirdPuzzle];

  /// Example escape room challenges for testing purposes.
  static const mockChallenges = EscapeRoomChallenges(
    firstPuzzle: Puzzle(
      question: 'How many bits are in a byte?',
      answer: '8',
      hint: 'It is an even number.',
      options: ['1', '2', '3', '4', '5', '6', '7', '8'],
    ),
    secondPuzzle: Puzzle(
      question: 'What programming language powers Flutter?',
      answer: 'Dart',
      hint: 'It was created by Google.',
      options: ['Java', 'Swift', 'Dart', 'Kotlin', 'Go', 'Rust', 'C#', 'HTML'],
    ),
    thirdPuzzle: Puzzle(
      question: 'Where is Google Cloud Next taking place in 2024?',
      answer: 'Las Vegas',
      hint: 'City located in the US.',
      options: [
        'Seattle',
        'San Francisco',
        'Rome',
        'Tokyo',
        'Madrid',
        'Las Vegas',
        'Chicago',
        'Sidney',
      ],
    ),
  );
}
