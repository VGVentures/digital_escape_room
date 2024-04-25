import 'dart:convert';

import 'package:ai_client/ai_client.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

/// {@template ai_client}
/// Google Generative AI API client.
/// {@endtemplate}
abstract class AiClient {
  /// Load escape room challenges based on a given [prompt].
  Future<EscapeRoomChallenges> loadGameChallenges(String prompt);
}

/// {@template ai_client_authenticated}
/// Authenticated Google Generative AI API client using [GenerativeModel].
/// {@endtemplate}
class AiClientAuthenticated implements AiClient {
  /// {@macro ai_client_authenticated}
  const AiClientAuthenticated(this._generativeModel);

  /// Create an authenticated Google Generative [AiClient] using an [apiKey].
  factory AiClientAuthenticated.withApiKey({required String apiKey}) =>
      AiClientAuthenticated(
        GenerativeModel(
          model: 'gemini-pro',
          apiKey: apiKey,
        ),
      );

  final GenerativeModel _generativeModel;

  @override
  Future<EscapeRoomChallenges> loadGameChallenges(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _generativeModel.generateContent(content);
      final cleanResponse = _removeMarkdownAnnotations(response.text!);
      final json = jsonDecode(cleanResponse) as Map<String, dynamic>;
      return EscapeRoomChallenges.fromJson(json);
    } catch (_) {
      return EscapeRoomChallenges.mockChallenges;
    }
  }

  String _removeMarkdownAnnotations(String content) {
    return content.replaceAll('`', '').replaceAll('json', '');
  }
}

/// {@template ai_client_unauthenticated}
/// Unauthenticated (fake) Google Generative AI API client using.
/// {@endtemplate}
class AiClientUnauthenticated implements AiClient {
  /// {@macro ai_client_unauthenticated}
  const AiClientUnauthenticated();

  @override
  Future<EscapeRoomChallenges> loadGameChallenges(String prompt) async {
    return EscapeRoomChallenges.mockChallenges;
  }
}
