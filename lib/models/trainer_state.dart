class TrainerState {
  final int runningCount;
  final int cardsDealt;
  final int currentCardRank;
  final int totalDecks;

  TrainerState({
    required this.runningCount,
    required this.cardsDealt,
    required this.currentCardRank,
    this.totalDecks = 8,
  });

  // Calculate True Count: Running Count / Decks Remaining
  double get trueCount {
    double decksRemaining = totalDecks - (cardsDealt / 52);
    return decksRemaining > 0 ? runningCount / decksRemaining : runningCount.toDouble();
  }

  // Initial empty state
  factory TrainerState.initial() => TrainerState(
        runningCount: 0,
        cardsDealt: 0,
        currentCardRank: 0,
      );

  TrainerState copyWith({int? rc, int? cd, int? rank}) {
    return TrainerState(
      runningCount: rc ?? runningCount,
      cardsDealt: cd ?? cardsDealt,
      currentCardRank: rank ?? currentCardRank,
      totalDecks: totalDecks,
    );
  }
}