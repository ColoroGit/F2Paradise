import 'package:f2paradise/pages/p_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          surface: const Color.fromARGB(255, 35, 35, 35),
          seedColor: const Color.fromARGB(255, 35, 35, 35),
          primary: const Color.fromARGB(255, 47, 79, 79),
          secondary: const Color.fromARGB(255, 31, 236, 255),
          tertiary: const Color.fromARGB(255, 167, 67, 255),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'F2Paradise'),
    );
  }
}
