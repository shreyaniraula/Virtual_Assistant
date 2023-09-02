import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:virtual_assistant/secret_key.dart';

class RapidAIService {
  Future<String> isArtPrompt(String prompt) async {
    try {
      Uri uri = Uri.https('ai-chatbot.p.rapidapi.com', "/chat/free", {
        'message':
            'Does this message want to generate an AI picture, art, image or anything similar? $prompt . Simply answer with a yes or no.',
        'uid': 'user'
      });
      final res = await http.get(
        uri,
        headers: {
          'X-RapidAPI-Key': rapidAIAPIKey,
          'X-RapidAPI-Host': 'ai-chatbot.p.rapidapi.com',
        },
      );
      if (res.statusCode == 200) {
        String response = json.decode(res.body)['chatbot']['response'];
        response = response.trim();

        switch (response) {
          case 'Yes.':
          case 'yes.':
          case 'Yes':
          case 'yes':
            final res = await imageRequest(prompt);
            return res;
          default:
            final res = await textRequest(prompt);
            return res;
        }
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> textRequest(String prompt) async {
    return 'Chatgpt';
  }

  Future<String> imageRequest(String prompt) async {
    return 'Image';
  }
}
