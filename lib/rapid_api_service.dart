import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:virtual_assistant/secret_key.dart';

class RapidAIService {
  final List<Map<String, String>> messages = [];

  Future<String> textRequest(String prompt) async {
    messages.add(
      {
        'role': 'user',
        'content': prompt,
      },
    );

    try {
      Uri uri = Uri.https('ai-chatbot.p.rapidapi.com', '/chat/free', {
        'message': prompt,
        'uid': 'user',
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

        messages.add(
          {
            'role': 'assistant',
            'content': response,
          },
        );
        return response;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

/*
  Future<String> imageRequest(String prompt) async {
    messages.add(
      {
        'role': 'user',
        'content': prompt,
      },
    );
    try {
      Uri uri = Uri.parse('https://api.replicate.com/v1/predictions');
      final res = await http.post(
        uri,
        headers: {
          'Authorization': 'Token $replicateAPIKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'version':
              '5c7d5dc6dd8bf75c1acaa8565735e7986bc5b66206b55cca93cb72c9bf15ccaa',
          'input': {'text': prompt},
        }),
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        // String response = json.decode(res.body)['items']['format'];
        // response = response.trim();
        // print(response);
        // return response;
        final imageUrl = jsonDecode(res.body)['urls']['get'];
        return imageUrl;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  Future<String> isArtPrompt(String prompt) async {
    try {
      Uri uri = Uri.https('ai-chatbot.p.rapidapi.com', '/chat/free', {
        'message':
            'Does this message want to generate an AI picture, art, image or anything similar? $prompt . Simply answer with a yes or no.',
        'uid': 'user',
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
  }*/
  }
