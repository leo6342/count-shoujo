import 'package:card_counter/screens/cardCount/training/controller/card_count_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultView extends StatelessWidget {
  final TrainingState trainingState;
  final VoidCallback onNextRound;
  final VoidCallback onRestart;

  const ResultView({
    super.key,
    required this.trainingState,
    required this.onNextRound,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final int userGuess = trainingState.userGuess;
    final int correctCount = trainingState.runningCount;

    final bool isCorrect = userGuess == correctCount;
    final int currentRound = trainingState.roundCount;
    final int totalRound = trainingState.config.totalRounds;

    // 1. Get action buttons dynamically via helper function
    List<Widget> actionButtons = _buildActionButtons(
      context: context,
      currentRound: currentRound,
      totalRound: totalRound,
    );
    List<Widget> correctDisplay = _buildIsCorrectDisplay(
        context: context, userGuess: userGuess, correctCount: correctCount);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const Text(
        //   "Training Complete!",
        //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        // ),
        ...correctDisplay,
        const SizedBox(height: 20),
        Text(
          "Final Correct Attempts: ${trainingState.correctAttempts} / $totalRound",
          style: const TextStyle(fontSize: 22, color: Colors.amber),
        ),
        const SizedBox(height: 50),
        ...actionButtons,
      ],
    );
  }

  List<Widget> _buildActionButtons({
    required BuildContext context,
    required int currentRound,
    required int totalRound,
  }) {
    print("currentRound: $currentRound; totalRound $totalRound");
    if (currentRound >= totalRound) {
      return [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700],
            minimumSize: const Size(200, 50),
          ),
          onPressed: onRestart,
          child: const Text("Restart", style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[700],
            minimumSize: const Size(200, 50),
          ),
          onPressed: () => context.pop(),
          child: const Text("Exit", style: TextStyle(color: Colors.white)),
        ),
      ];
    } else {
      return [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700],
            minimumSize: const Size(200, 50),
          ),
          onPressed: onNextRound,
          child:
              const Text("Next Round", style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[700],
            minimumSize: const Size(200, 50),
          ),
          onPressed: () => context.pop(),
          child: const Text("Exit", style: TextStyle(color: Colors.white)),
        ),
      ];
    }
  }

  List<Widget> _buildIsCorrectDisplay(
      {required BuildContext context,
      required userGuess,
      required correctCount}) {
    if (userGuess == correctCount) {
      return [
        const Text(
          "Correct!",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ];
    } else {
      return [
        const Text(
          "Not Correct...",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),
        ),
        Text(
          "Your Guess: $userGuess",
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          "Actual Count: $correctCount",
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        )
      ];
    }
  }
}
