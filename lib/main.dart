import 'package:flutter/material.dart';

void main() {
  runApp(const TimedNotesApp());
}

class TimedNotesApp extends StatelessWidget {
  const TimedNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timed Notes',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timed Notes'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Timed Notes',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
