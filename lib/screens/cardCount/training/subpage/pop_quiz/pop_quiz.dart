import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// View 2: Pop Quiz Input Screen
class PopQuizView extends StatelessWidget {
  final int userGuess;
  final ValueChanged<int> onGuessChanged;
  final VoidCallback onReset;
  final VoidCallback onSubmit;

  const PopQuizView({
    super.key,
    required this.userGuess,
    required this.onGuessChanged,
    required this.onReset,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Pop Quiz!",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          "What is the current running count?",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 30),

        // Display user's current built guess
        Text(
          "Your Answer: $userGuess",
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        const SizedBox(height: 30),

        // UI buttons: -10, -5, -1, +1, +5, +10
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            _countButton(-10),
            _countButton(-5),
            _countButton(-1),
            _countButton(1),
            _countButton(5),
            _countButton(10),
          ],
        ),
        const SizedBox(height: 40),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              onPressed: onReset,
              child: const Text("Reset", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: onSubmit,
              child: const Text(
                "Submit Answer",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _countButton(int delta) {
    String label = delta > 0 ? "+$delta" : "$delta";
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(80, 50),
        backgroundColor: delta > 0 ? Colors.blueGrey[700] : Colors.brown[700],
      ),
      onPressed: () => onGuessChanged(delta),
      child: Text(
        label,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}