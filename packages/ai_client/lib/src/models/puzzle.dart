import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'puzzle.g.dart';

@JsonSerializable(createFactory: true, createToJson: false)
class Puzzle extends Equatable {
  const Puzzle({
    required this.question,
    required this.answer,
    required this.hint,
    required this.options,
  });

  factory Puzzle.fromJson(Map<String, dynamic> json) => _$PuzzleFromJson(json);

  @JsonKey(name: 'question')
  final String question;

  @JsonKey(name: 'answer')
  final String answer;

  @JsonKey(name: 'hint')
  final String hint;

  @JsonKey(name: 'options')
  final List<String> options;

  @override
  List<Object> get props => [question, answer, hint, options];
}
