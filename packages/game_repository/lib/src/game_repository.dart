import 'package:ai_client/ai_client.dart';

class GameRepository {
  const GameRepository(this._aiClient);

  final AiClient _aiClient;

  Future<(String, EscapeRoomChallenges)> loadChallenges({
    required String playerFullName,
    required String playerCompany,
    required String playerRoleTitle,
    required List<String> areasOfInterest,
  }) async {
    final prompt = promptForMultipleChoiceChallenge(
      playerFullName: playerFullName,
      playerCompany: playerCompany,
      playerRoleTitle: playerRoleTitle,
      areasOfInterest: areasOfInterest,
    );
    final gameChallenges = await _aiClient.loadGameChallenges(prompt);
    final validatedChallenges =
        _validateThatPuzzleOptionsContainAnswer(gameChallenges);
    return (prompt, validatedChallenges);
  }

  EscapeRoomChallenges _validateThatPuzzleOptionsContainAnswer(
    EscapeRoomChallenges challenges,
  ) {
    return EscapeRoomChallenges(
      firstPuzzle: _validatePuzzle(challenges.firstPuzzle),
      secondPuzzle: _validatePuzzle(challenges.secondPuzzle),
      thirdPuzzle: _validatePuzzle(challenges.thirdPuzzle),
    );
  }

  Puzzle _validatePuzzle(Puzzle puzzle) {
    if (puzzle.options.contains(puzzle.answer)) {
      return puzzle;
    } else {
      puzzle.options
        ..add(puzzle.answer)
        ..shuffle();
      return puzzle;
    }
  }
}
