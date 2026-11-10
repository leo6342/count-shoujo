import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardCountMenu extends StatelessWidget {
  const CardCountMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Home screen UI
    return Scaffold(
      backgroundColor: Color(0xFFDFD1BE), // Parchment color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Card Count Main?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 50),
// Inside CardCountMain build method:
            _menuButton(context, "+1 Training", "/cardCountTraining/plus_one"),
            const SizedBox(height: 20),
            _menuButton(context, "-1 Training", "/cardCountTraining/minus_one"),
            const SizedBox(height: 20),
            _menuButton(
                context, "Only +1 -1", "/cardCountTraining/mixed_basic"),
            const SizedBox(height: 20),
            _menuButton(context, "Full Count", "/cardCountTraining/full"),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(BuildContext context, String label, String route) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[700]),
        onPressed: () => context.push(route),
        child: Text(label, style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}
