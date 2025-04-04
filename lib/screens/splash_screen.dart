import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spatiotrackplus/screens/home_screen.dart';
import 'package:spatiotrackplus/screens/login_screen.dart';
import 'package:spatiotrackplus/providers/session_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      final session = ref.read(sessionProvider); // Get session state
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => session.isLoggedIn ? const HomePage() : LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.20, -0.98),
            end: Alignment(-0.2, 0.98),
            colors: [Color(0xFF000B41), Color(0xFF000B42), Color(0xFF001CA7)],
          ),
        ),
        child: Stack(
          children: [
            // Logo Image from Assets
            Positioned(
              left: 81,
              top: 378,
              child: Container(
                width: 228,
                height: 88,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/frame_4r.png"), // Load from assets
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Status Bar Background
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 390,
                height: 35,
                decoration: const BoxDecoration(color: Color(0xFF0A0741)),
              ),
            ),

            // Bottom Navigation Bar
            Positioned(
              left: 0,
              top: 805,
              child: Container(
                width: 390,
                height: 39,
                padding: const EdgeInsets.only(
                  top: 26,
                  left: 128,
                  right: 128,
                  bottom: 8,
                ),
                decoration: const BoxDecoration(color: Color(0xFF001997)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 134,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Loading Indicator
            const Positioned(
              left: 0,
              right: 0,
              bottom: 100,
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
