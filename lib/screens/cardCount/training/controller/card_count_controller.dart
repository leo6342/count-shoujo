import 'package:card_counter/screens/cardCount/training/controller/game_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:card_counter/common/cards/shoes.dart';
import 'package:card_counter/common/cards/playingCard.dart';
import 'package:card_counter/common/helpers/getRandomInt.dart';

class TrainingState {
  final CardCountGameConfig config;
  final Shoe shoe;
  final PlayingCard? currentCard;
  final int nCards; // Your exact variable name

  final int correctAttempts;
  final int runningCount;
  final int userGuess;

  final int roundCount;
  final int targetCardsForQuiz;
  final bool isGameOver;
  final bool isQuizActive;

  TrainingState({
    required this.shoe,
    required this.config,
    this.roundCount = 0,
    this.correctAttempts = 0,
    this.isGameOver = false,
    this.currentCard,
    this.runningCount = 0,
    this.nCards = 0,
    required this.targetCardsForQuiz,
    this.isQuizActive = false,
    this.userGuess = 0,
  });

  TrainingState copyWith({
    Shoe? shoe,
    CardCountGameConfig? config,
    int? roundCount,
    int? correctAttempts,
    bool? isGameOver,
    PlayingCard? currentCard,
    int? runningCount,
    int? nCards, // Strictly using nCards
    int? targetCardsForQuiz,
    bool? isQuizActive,
    int? userGuess,
  }) {
    return TrainingState(
      shoe: shoe ?? this.shoe,
      config: config ?? this.config,
      roundCount: roundCount ?? this.roundCount,
      correctAttempts: correctAttempts ?? this.correctAttempts,
      isGameOver: isGameOver ?? this.isGameOver,
      currentCard: currentCard ?? this.currentCard,
      runningCount: runningCount ?? this.runningCount,
      nCards: nCards ?? this.nCards, // Strictly mapping nCards
      targetCardsForQuiz: targetCardsForQuiz ?? this.targetCardsForQuiz,
      isQuizActive: isQuizActive ?? this.isQuizActive,
      userGuess: userGuess ?? this.userGuess,
    );
  }
}

class CardCountController
    extends FamilyNotifier<TrainingState, CardCountGameConfig> {
  @override
  TrainingState build(CardCountGameConfig config) {
    final shoe =
        Shoe(numberOfDecks: config.numberOfDecks, filter: config.filter);
    shoe.reset();

    final minCards = config.minCardsPerRound;
    final maxCards = config.maxCardsPerRound;

    return TrainingState(
      shoe: shoe,
      config: config,
      targetCardsForQuiz: getRandomInt(minCards, maxCards),
    );
  }

  void reset() {
    print("===== reset =====");

    state.shoe.reset();
    final minCards = state.config.minCardsPerRound;
    final maxCards = state.config.maxCardsPerRound;

    state = state.copyWith(
      runningCount: 0,
      nCards: 0, // Using nCards
      targetCardsForQuiz: getRandomInt(minCards, maxCards),
      currentCard: null,
      isQuizActive: false,
      userGuess: 0,
    );
  }

  void restartSession() {
    print("===== restartSession =====");

    state.shoe.reset();
    final minCards = state.config.minCardsPerRound;
    final maxCards = state.config.maxCardsPerRound;

    state = TrainingState(
      shoe: state.shoe,
      config: state.config,
      roundCount: 0,
      correctAttempts: 0,
      isGameOver: false,
      isQuizActive: false,
      runningCount: 0,
      nCards: 0, // Using nCards
      userGuess: 0,
      targetCardsForQuiz: getRandomInt(minCards, maxCards),
    );
  }

  void drawNextCard() {
    if (state.isQuizActive || state.isGameOver) return;

    final card = state.shoe.drawCard();
    final newCardCount = state.nCards + 1;
    final reachedTarget = newCardCount >= state.targetCardsForQuiz;

    state = state.copyWith(
      currentCard: card,
      runningCount: state.runningCount + card.hiLoValue,
      nCards: newCardCount,
      isQuizActive: reachedTarget,
    );
  }

  void updateUserGuess(int delta) {
    state = state.copyWith(userGuess: state.userGuess + delta);
  }

  void resetUserGuess() {
    state = state.copyWith(userGuess: 0);
  }

  void submitQuizAnswer() {
    bool isCorrect = (state.userGuess == state.runningCount);
    int newCorrectAttempts =
        isCorrect ? state.correctAttempts + 1 : state.correctAttempts;
    int nextRoundCount = state.roundCount + 1;

    if (nextRoundCount >= 1) {
      state = state.copyWith(
        correctAttempts: newCorrectAttempts,
        roundCount: nextRoundCount,
        isGameOver: true,
        isQuizActive: false,
      );
    } else {
      state = state.copyWith(
        correctAttempts: newCorrectAttempts,
        roundCount: nextRoundCount,
      );
      reset();
    }
  }

  void nextRound() {

  }
}

final cardCountControllerProvider = NotifierProvider.family<CardCountController,
    TrainingState, CardCountGameConfig>(CardCountController.new);
