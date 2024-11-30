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
          seedColor: const Color(0xFF1FECFF),
          surface: const Color.fromARGB(255, 0, 0, 0),
          primary: const Color(0xFF232323),
          secondary: const Color(0xFF1FECFF),
          tertiary: const Color(0xFFA743FF),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'F2Paradise'),
    );
  }
}
