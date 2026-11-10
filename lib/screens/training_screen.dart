import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import '../providers/trainer_provider.dart';

class TrainingScreen extends ConsumerWidget {
  const TrainingScreen({super.key});

  void _checkCountPopup(BuildContext context, double trueCount, int runningCount) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("COUNT CHECK"),
        content: Text("Running Count: $runningCount\nTrue Count: ${trueCount.toStringAsFixed(1)}"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("CONTINUE")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trainerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("8-Deck Drill"), backgroundColor: Colors.transparent),
      backgroundColor: const Color(0xFF1A3622),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          ref.read(trainerProvider.notifier).nextCard();
          // 10% chance to trigger a pop-up to test the user
          if (Random().nextDouble() < 0.10) {
            _checkCountPopup(context, state.trueCount, state.runningCount);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.currentCardRank == 0 ? "TAP TO START" : "${_rankToName(state.currentCardRank)}",
                style: const TextStyle(color: Colors.white, fontSize: 80, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text("Cards Dealt: ${state.cardsDealt}", style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }

  String _rankToName(int rank) {
    if (rank == 1) return "A";
    if (rank == 11) return "J";
    if (rank == 12) return "Q";
    if (rank == 13) return "K";
    return rank.toString();
  }
}