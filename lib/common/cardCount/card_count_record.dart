import 'dart:convert';

class CardCountRecord {
  // --- Required Fields ---
  final String id;                    // Unique identifier (e.g., UUID or timestamp string)
  final DateTime datetime;            // When the training round took place
  final String mode;                  // Training mode ('plus_one', 'minus_one', etc.)
  final bool isCorrect;               // Whether the user's final count guess was right
  final double timePerCardSeconds;    // Average time spent looking at each card

  // --- Additional Statistical Fields ---
  final int actualCount;              // The true running count calculated by the shoe
  final int userGuess;                // What the user submitted as their guess
  final int totalCardsDrawn;          // Number of cards in this specific round
  final int totalDurationSeconds;     // Total time taken to complete the round
  final int decksCount;               // Number of decks in play (e.g., 1, 6)

  CardCountRecord({
    required this.id,
    required this.datetime,
    required this.mode,
    required this.isCorrect,
    required this.timePerCardSeconds,
    required this.actualCount,
    required this.userGuess,
    required this.totalCardsDrawn,
    required this.totalDurationSeconds,
    required this.decksCount,
  });

  // Convert to Map for local storage (JSON serialization)
  Map<String, dynamic> toJson() => {
        'id': id,
        'datetime': datetime.toIso8601String(),
        'mode': mode,
        'isCorrect': isCorrect,
        'timePerCardSeconds': timePerCardSeconds,
        'actualCount': actualCount,
        'userGuess': userGuess,
        'totalCardsDrawn': totalCardsDrawn,
        'totalDurationSeconds': totalDurationSeconds,
        'decksCount': decksCount,
      };

  // Create object from Map when reading back from local storage
  factory CardCountRecord.fromJson(Map<String, dynamic> json) => CardCountRecord(
        id: json['id'] ?? '',
        datetime: DateTime.parse(json['datetime']),
        mode: json['mode'] ?? '',
        isCorrect: json['isCorrect'] ?? false,
        timePerCardSeconds: (json['timePerCardSeconds'] as num).toDouble(),
        actualCount: json['actualCount'] ?? 0,
        userGuess: json['userGuess'] ?? 0,
        totalCardsDrawn: json['totalCardsDrawn'] ?? 0,
        totalDurationSeconds: json['totalDurationSeconds'] ?? 0,
        decksCount: json['decksCount'] ?? 6,
      );

  // Helper getters for advanced stats display
  int get errorMargin => (userGuess - actualCount).abs(); // How far off they were
}