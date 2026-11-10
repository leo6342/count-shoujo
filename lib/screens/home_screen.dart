import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Home screen UI
    return Scaffold(
      backgroundColor: const Color(0xFFDFD1BE), // Parchment color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("NIGGA?", 
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 50),
            _menuButton(context, "Card Count", "/cardCountMain"),
            const SizedBox(height: 20),
            _menuButton(context, "Basic Strategy", "/basicStrategyMain"),
            const SizedBox(height: 20),
            _menuButton(context, "Statistic", "/statMain"),
            const SizedBox(height: 20),
            // _menuButton(context, "STATISTICS", "/stats"),
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