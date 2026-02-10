import 'package:flutter/material.dart';
import 'grapevine_predictor.dart';

void main() {
  runApp(const GrapevineApp());
}

class GrapevineApp extends StatelessWidget {
  const GrapevineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grapevine Disease Detector',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF8FAF8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const GrapevinePredictor(),
    );
  }
}
