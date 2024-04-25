// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'puzzle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Puzzle _$PuzzleFromJson(Map<String, dynamic> json) => Puzzle(
      question: json['question'] as String,
      answer: json['answer'] as String,
      hint: json['hint'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
    );
