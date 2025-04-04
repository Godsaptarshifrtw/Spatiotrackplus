import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spatiotrackplus/screens/home_screen.dart';
import 'package:spatiotrackplus/screens/login_screen.dart';
import 'package:spatiotrackplus/screens/splash_screen.dart';
import 'package:spatiotrackplus/providers/session_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpatioTrackPlus',
      home: const SplashPage(), // Start with splash screen
    );
  }
}
