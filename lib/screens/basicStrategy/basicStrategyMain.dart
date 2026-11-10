import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BasicStrategyMain extends StatelessWidget {
  const BasicStrategyMain({super.key});

  @override
  Widget build(BuildContext context) {
    // Home screen UI
    return const Scaffold(
      backgroundColor: Color(0xFFDFD1BE), // Parchment color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Basic Strategy Main", 
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 50)
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