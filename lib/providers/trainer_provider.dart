import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import '../models/trainer_state.dart';

class TrainerNotifier extends StateNotifier<TrainerState> {
  TrainerNotifier() : super(TrainerState.initial());

  // TODO: true shoes

  void nextCard() {
    // Generate rank 1(Ace) to 13(King)
    final rank = Random().nextInt(13) + 1;
    int weight = 0;

    // Hi-Lo Logic
    if (rank >= 10 || rank == 1) {
      weight = -1;
    }
    if (rank >= 2 && rank <= 6) {
      weight = 1;
    }

    state = state.copyWith(
      rc: state.runningCount + weight,
      cd: state.cardsDealt + 1,
      rank: rank,
    );
  }

  void reset() => state = TrainerState.initial();
}

final trainerProvider =
    StateNotifierProvider<TrainerNotifier, TrainerState>((ref) {
  return TrainerNotifier();
});
