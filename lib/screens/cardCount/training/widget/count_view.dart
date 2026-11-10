// lib/screens/cardCount/training/widget/count_view.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_counter/common/cards/playingCard.dart';

/// View 1: Normal card drawing loop
class CountView extends StatelessWidget {
  final int roundCount;
  final int cardsDrawn;
  final int targetCards;
  final PlayingCard? currentCard;
  final VoidCallback onNext;

  const CountView({
    super.key,
    required this.roundCount,
    required this.cardsDrawn,
    required this.targetCards,
    required this.currentCard,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Round: ${roundCount + 1} / 10",
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Text(
          "Cards Drawn: $cardsDrawn / $targetCards",
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 40),

        // Realistic Poker Card Display Box
        Container(
          width: 140,
          height: 200,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: currentCard == null
              ? const Center(
                  child: Text(
                    "Press Next",
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                )
              : _buildCardContent(currentCard!),
        ),
        const SizedBox(height: 50),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber[700],
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          onPressed: onNext,
          child: const Text(
            "Next",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ],
    );
  }

  /// Helper to layout a proper poker card look with corner indicators & center symbol
  Widget _buildCardContent(PlayingCard card) {
    final bool isRed = card.suit == Suit.hearts || card.suit == Suit.diamonds;
    final Color cardColor = isRed ? Colors.red.shade700 : Colors.black87;

    return Stack(
      children: [
        // Top-Left Rank & Suit
        Positioned(
          top: 2,
          left: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                card.rank,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: cardColor,
                  height: 1.0,
                ),
              ),
              Text(
                _getSuitSymbol(card.suit),
                style: TextStyle(
                  fontSize: 14,
                  color: cardColor,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),

        // Center Big Suit & Rank Display
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _getSuitSymbol(card.suit),
                style: TextStyle(
                  fontSize: 48,
                  color: cardColor,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                card.rank,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: cardColor,
                ),
              ),
            ],
          ),
        ),

        // Bottom-Right Upside-Down Rank & Suit (Rotated 180 degrees)
        Positioned(
          bottom: 2,
          right: 2,
          child: Transform.rotate(
            angle: 3.14159, // 180 degrees in radians
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  card.rank,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: cardColor,
                    height: 1.0,
                  ),
                ),
                Text(
                  _getSuitSymbol(card.suit),
                  style: TextStyle(
                    fontSize: 14,
                    color: cardColor,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Maps your Suit enum to standard poker symbols
  String _getSuitSymbol(Suit suit) {
    switch (suit) {
      case Suit.hearts:
        return '♥';
      case Suit.diamonds:
        return '♦';
      case Suit.clubs:
        return '♣';
      case Suit.spades:
        return '♠';
    }
  }
}