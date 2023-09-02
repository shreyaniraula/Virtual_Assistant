import 'package:flutter/material.dart';
import 'package:virtual_assistant/home_page.dart';
import 'package:virtual_assistant/pallete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true).copyWith(scaffoldBackgroundColor: Pallete.whiteColor),
      home: const HomePage(),
    );
  }
}
