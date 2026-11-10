import 'package:card_counter/constant/defaultDeck.dart';
import 'model.dart';


// TODO: since logic here seems to be used in multiple places
// May move this to somewhere common use
class DeckController {
  DeckModel? shoes;

  DeckController() {
    shoes = DeckModel(
      deck: defaultDeck,
      count: [],
      currentIndex: 0,
    );
    print("HUH");
    initDeck();
  }

  void initDeck({int nDeck = 1}) {
    print("init");
    shoes!.deck = defaultDeck;
    // TODO: add nDeck
    _shuffle();
    // shoes.deck.shuffle;
  }

  // shuffle
  void _shuffle() {
    shoes!.deck.shuffle();
    _setCount();
  }

  void nextCard() {
    shoes!.currentIndex++;
  }

  void _setCount() {
    List<int> count = [];
    for (int i = 0; i < shoes!.deck.length; i++) {
      String card = shoes!.deck[i];
      String cardValue = card[1];

      int countValue = 0;
      int prevCount = i == 0 ? 0 : count[i - 1];

      if (cardValue == 'T' ||
          cardValue == 'J' ||
          cardValue == 'Q' ||
          cardValue == 'K' ||
          cardValue == 'A') {
        countValue = -1;
      }

      if (cardValue == '2' ||
          cardValue == '3' ||
          cardValue == '4' ||
          cardValue == '5' ||
          cardValue == '6') {
        countValue = 1;
      }

      int currentCount = prevCount + countValue;
      count.add(currentCount);
    }
    shoes!.count = count;
    print(count);
  }

  // TODO: Count
  String getCurrentCard() {
    return shoes!.deck[shoes!.currentIndex];
  }
}
