import 'package:card_counter/screens/basicStrategy/basicStrategyMain.dart';
import 'package:card_counter/screens/cardCount/card_count_menu.dart';
import 'package:card_counter/screens/cardCount/training/training_screen.dart';
import 'package:card_counter/screens/statistic/statisticMain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: BlackjackApp()));
}

// Rount Management
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    // main menu
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    // Card Counting
    GoRoute(
      path: '/cardCountMain',
      builder: (context, state) => const CardCountMenu(),
    ),
    GoRoute(
      path:
          '/cardCountTraining/:mode', // e.g., /cardCountTraining/plus_one, /cardCountTraining/full
      builder: (context, state) {
        // Extract the mode parameter from the route URL
        final mode = state.pathParameters['mode'] ?? 'default';
        return CardCountTrainingScreen (gameMode: mode);
      },
    ),
    // Basic Strategy
    GoRoute(
      path: '/basicStrategyMain',
      builder: (context, state) => const BasicStrategyMain(),
    ),
    GoRoute(
      path: '/statMain',
      builder: (context, state) => const StatisticMain(),
    ),
  ],
);

class BlackjackApp extends StatelessWidget {
  const BlackjackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}
