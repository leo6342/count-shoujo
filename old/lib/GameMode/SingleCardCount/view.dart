import 'package:card_counter/common/deckController/controller.dart';
import 'package:card_counter/common/deckController/model.dart';
import 'package:flutter/material.dart';

class SingleCardCount extends StatefulWidget {
  const SingleCardCount({super.key});

  @override
  State<SingleCardCount> createState() => _SingleCardCountState();
}

class _SingleCardCountState extends State<SingleCardCount> {
  late DeckController dc = DeckController();

  // TODO: init deck

  // dc.initDeck();
  @override
  Widget build(BuildContext context) {


    DeckModel shoes = dc.shoes!;
    int idx = shoes.currentIndex;
    List<int> count = shoes.count;

    print(shoes);
    print(idx);
    print(count);
    // print(idx);

    int currentCount = shoes.count[idx];
    String currentCard = shoes.deck[idx];

    return Center(
      child: Column(
        children: [
          Text("Current Card: " + currentCard),
          Text("Count: " + currentCount.toString()),
          Text("Card Idx: " + idx.toString()),
          TextButton(
            onPressed: () {
              setState(() {
                dc.nextCard();
              });
            },
            child: const Text("Next Card!"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                dc.initDeck();
              });
            },
            child: const Text("Reset Deck!"),
          ),
        ],
      ),
    );
  }
}
