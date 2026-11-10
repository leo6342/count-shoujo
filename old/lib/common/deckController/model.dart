class DeckModel {
  List<String> deck = ['DA', 'CA', 'HA', 'SA'];
  List<int> count = [];
  int currentIndex = 0;

  DeckModel({
    required this.deck,
    required this.count,
    required this.currentIndex,
  });
}
