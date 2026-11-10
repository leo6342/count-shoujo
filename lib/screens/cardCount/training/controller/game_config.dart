// lib/screens/cardCount/training/controller/game_config.dart

import 'package:card_counter/common/cards/shoes.dart';

class CardCountGameConfig {
  final int numberOfDecks;
  final int minCardsPerRound;
  final int maxCardsPerRound;
  final int totalRounds;
  final Filter filter;

  const CardCountGameConfig({
    this.numberOfDecks = 6,
    this.minCardsPerRound = 8,
    this.maxCardsPerRound = 12,
    this.totalRounds = 10, // Max rounds per training session
    this.filter = Filter.noFilter,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardCountGameConfig &&
          runtimeType == other.runtimeType &&
          numberOfDecks == other.numberOfDecks &&
          minCardsPerRound == other.minCardsPerRound &&
          maxCardsPerRound == other.maxCardsPerRound &&
          totalRounds == other.totalRounds &&
          filter == other.filter;

  @override
  int get hashCode =>
      numberOfDecks.hashCode ^
      minCardsPerRound.hashCode ^
      maxCardsPerRound.hashCode ^
      totalRounds.hashCode ^
      filter.hashCode;
}