import 'package:card_counter/common/cards/shoes.dart';
import 'package:card_counter/screens/cardCount/training/controller/card_count_controller.dart';
import 'package:card_counter/screens/cardCount/training/controller/game_config.dart';
import 'package:card_counter/screens/cardCount/training/widget/count_view.dart';
import 'package:card_counter/screens/cardCount/training/widget/pop_quiz.dart';
import 'package:card_counter/screens/cardCount/training/widget/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardCountTrainingScreen extends ConsumerWidget {
  final String gameMode;
  const CardCountTrainingScreen({super.key, required this.gameMode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Filter filter = _getShoeFilter(gameMode);

    // ✅ FIX: Use a stable config instance or cache it based on gameMode.
    // Since gameMode doesn't change, we can memoize or use a constant/static config per mode,
    // or ensure CardCountGameConfig overrides operator == and hashCode.
    final CardCountGameConfig config = _getConfigForMode(gameMode);

    final state = ref.watch(cardCountControllerProvider(config));
    final controller = ref.read(cardCountControllerProvider(config).notifier);

    String title = _getTitleForMode(gameMode);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: state.isGameOver
              ? ResultView(
                  correctAttempts: state.correctAttempts,
                  onRestart: () => controller.restartSession(),
                )
              : state.isQuizActive
                  ? PopQuizView(
                      userGuess: state.userGuess,
                      onGuessChanged: (delta) =>
                          controller.updateUserGuess(delta),
                      onReset: () => controller.resetUserGuess(),
                      onSubmit: () => controller.submitQuizAnswer(),
                    )
                  : CountView(
                      roundCount: state.roundCount,
                      cardsDrawn: state.nCards,
                      targetCards: state.targetCardsForQuiz,
                      currentCard: state.currentCard,
                      onNext: () => controller.drawNextCard(),
                    ),
        ),
      ),
    );
  }

  // ✅ Helper to return a stable config instance per mode
  CardCountGameConfig _getConfigForMode(String mode) {
    return CardCountGameConfig(
      totalRounds: 10,
      filter: _getShoeFilter(mode),
    );
  }

  String _getTitleForMode(String mode) {
    switch (mode) {
      case 'plus_one':
        return '+1 Drill Training';
      case 'minus_one':
        return '-1 Drill Training';
      case 'mixed_basic':
        return 'Only +1 / -1 Mode';
      case 'full':
        return 'Full Card Counting Game';
    }
    return 'Training Mode';
  }

  Filter _getShoeFilter(String mode) {
    switch (mode) {
      case 'plus_one':
        return Filter.plusOne;
      case 'minus_one':
        return Filter.minusOne;
      case 'mixed_basic':
        return Filter.noZero;
      case 'full':
        return Filter.noFilter;
    }
    return Filter.noFilter;
  }
}
