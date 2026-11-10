import 'dart:math';

/// Generates a random integer between min and max (inclusive)
int getRandomInt(int min, int max) {
  return min + Random().nextInt(max - min + 1);
}