enum Suit { hearts, diamonds, clubs, spades }

class PlayingCard {
  final String rank;      // e.g., '2', '10', 'J', 'A'
  final Suit suit;        // Hearts, Diamonds, Clubs, Spades
  final int hiLoValue;    // Hi-Lo value: +1, 0, or -1

  const PlayingCard({
    required this.rank,
    required this.suit,
    required this.hiLoValue,
  });

  @override
  String toString() => '$rank of ${suit.name} (Hi-Lo: $hiLoValue)';
}