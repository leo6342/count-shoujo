import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// View 3: Final Score Summary Screen
class ResultView extends StatelessWidget {
  final int correctAttempts;
  final VoidCallback onRestart;

  const ResultView({
    super.key,
    required this.correctAttempts,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Training Complete!",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          "Final Correct Attempts: $correctAttempts / 10",
          style: const TextStyle(fontSize: 22, color: Colors.amber),
        ),
        const SizedBox(height: 50),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700],
            minimumSize: const Size(200, 50),
          ),
          onPressed: onRestart,
          child: const Text(
            "Restart",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[700],
            minimumSize: const Size(200, 50),
          ),
          onPressed: () => context.pop(), // Pops back to menu safely
          child: const Text(
            "Quit",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
