import 'dart:async';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  final String note;
  final int totalSeconds;

  const TimerScreen({
    super.key,
    required this.note,
    required this.totalSeconds,
  });

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? timer;
  late int remainingSeconds;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.totalSeconds;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused && remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      }

      if (remainingSeconds == 0) {
        timer.cancel();
        showFinishedDialog();
      }
    });
  }

  void showFinishedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Time is up!'),
        content: Text(widget.note.isEmpty ? 'Your timer finished.' : widget.note),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String formatTime(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;

    return '${h.toString().padLeft(2, '0')}:'
        '${m.toString().padLeft(2, '0')}:'
        '${s.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteText = widget.note.trim().isEmpty ? 'Timed Note' : widget.note.trim();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              Text(
                noteText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              Text(
                formatTime(remainingSeconds),
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isPaused = !isPaused;
                    });
                  },
                  child: Text(isPaused ? 'RESUME' : 'PAUSE'),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
