import 'dart:math';

import 'package:card_counter/common/cards/playingCard.dart';


enum Filter { noFilter, plusOne, minusOne, noZero }

class Shoe {
  final int numberOfDecks;
  final List<PlayingCard> _cards = [];
  final Random _random = Random();
  final Filter filter;

  Shoe({
    this.numberOfDecks = 6,
    this.filter = Filter.noFilter,
  }) {
    reset();
  }

  /// Resets the shoe by generating all decks and shuffling them
  void reset() {
    _cards.clear();
    const ranks = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'];

    for (int d = 0; d < numberOfDecks; d++) {
      for (var suit in Suit.values) {
        for (var rank in ranks) {
          int hiLo = _getHiLoValue(rank);
          _cards.add(PlayingCard(rank: rank, suit: suit, hiLoValue: hiLo));
        }
      }
    }

    // Remove cards in shoes by filter
    if (filter != Filter.noFilter) {
      _cards.removeWhere((card) {
        switch (filter) {
          case Filter.plusOne:
            // Keep ONLY cards with a Hi-Lo value of +1 and 0
            return card.hiLoValue != 1 && card.hiLoValue != 0;
          case Filter.minusOne:
            // Keep ONLY cards with a Hi-Lo value of -1 and 0
            return card.hiLoValue != -1  && card.hiLoValue != 0;
          case Filter.noZero:
            // Remove neutral cards (0), keeping only +1 and -1 cards
            return card.hiLoValue == 0;
          case Filter.noFilter:
            return false;
        }
      });
    }

    _cards.shuffle(_random);
  }

  /// Determines the Hi-Lo value based on standard blackjack rules
  int _getHiLoValue(String rank) {
    switch (rank) {
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
        return 1;  // Low cards favor the player
      case '7':
      case '8':
      case '9':
        return 0;  // Neutral cards
      case '10':
      case 'J':
      case 'Q':
      case 'K':
      case 'A':
        return -1; // High cards favor the house
      default:
        return 0;
    }
  }

  /// Draws a single card from the shoe. Reshuffles automatically if empty.
  PlayingCard drawCard() {
    if (_cards.isEmpty) {
      reset();
    }
    return _cards.removeLast();
  }

  /// Number of cards left in the shoe
  int get cardsRemaining => _cards.length;

  /// Estimated decks remaining (used for calculating True Count = Running Count / Decks Remaining)
  double get decksRemaining => _cards.length / 52.0;
}