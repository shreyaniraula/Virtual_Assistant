import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:virtual_assistant/secret_key.dart';

class OpenAIService {
  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $OpenAIAPIKey",
        },
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content":
                    "Does this message want to generate an AI picture, art, image or anything similar? $prompt . Simply answer with a yes or no.",
              }
            ],
          },
        ),
      );
      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        switch (content) {
          case 'yes.':
          case 'Yes.':
          case 'yes':
          case 'Yes':
            print(content);
          default:
            print(content);
        }
      }
      return 'AI';
    } catch (e) {
      return e.toString();
    }
  }

// Future<String> ChatGPTAPI(String prompt) async{

// }
// Future<String> DALLEAPI(String prompt) async{}
}
