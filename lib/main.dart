import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(199, 128, 250,1),
          secondary: const Color.fromRGBO(227, 172, 249,1),
          background: const Color.fromRGBO(251, 241, 211,1)
        ),

        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}


