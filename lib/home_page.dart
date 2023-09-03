import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:virtual_assistant/feature_box.dart';
import 'package:virtual_assistant/pallete.dart';
import 'package:virtual_assistant/rapid_api_service.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SpeechToText speechToText = SpeechToText();
  FlutterTts textToSpeech = FlutterTts();
  String lastWords = '';
  RapidAIService rapidAIService = RapidAIService();
  bool contentPresent = false;
  String? generatedContent;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    textToSpeech.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    textToSpeech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doraemon'),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              //Assistant image on blue circle
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4.0),
                    height: 120.0,
                    decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: 123.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/virtualAssistant.png')),
                    ),
                  ),
                ],
              ),

              //Chat box
              Container(
                margin: const EdgeInsets.only(top: 12.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Pallete.borderColor),
                  borderRadius: BorderRadius.circular(20.0).copyWith(
                    topLeft: Radius.zero,
                  ),
                ),
                child: Text(
                  generatedContent ??
                      'Good Morning! What task can I do for you?',
                  style: TextStyle(
                    color: Pallete.mainFontColor,
                    fontSize: generatedContent == null ? 25.0 : 18.0,
                    fontFamily: 'Cera Pro',
                  ),
                ),
              ),

              //Here are a few commands
              Visibility(
                visible: generatedContent == null,
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Here are a few commands',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Cera Pro',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              //Cards of chatgpt, dall-e...
              Visibility(
                visible: generatedContent==null,
                child: const Column(
                  children: [
                    FeatureBox(
                      headerText: 'ChatGPT',
                      descriptionText:
                          'A smarter way to stay organized and informed with ChatGPT',
                      boxColor: Pallete.firstSuggestionBoxColor,
                    ),
                    FeatureBox(
                      headerText: 'Smart Voice Assistant',
                      descriptionText:
                          'Your own Smart Assistant',
                      boxColor: Pallete.thirdSuggestionBoxColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.firstSuggestionBoxColor,
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            generatedContent = await rapidAIService.textRequest(lastWords);
            await systemSpeak(generatedContent!);
            setState(() {});
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        child: const Icon(
          Icons.mic,
        ),
      ),
    );
  }
}
