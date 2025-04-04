import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spatiotrackplus/providers/auth_provider.dart';
import 'package:spatiotrackplus/screens/profile_screen.dart';
import 'package:spatiotrackplus/screens/sidebar.dart';
import 'package:spatiotrackplus/screens/subscription_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to different screens based on index
    if (index == 1) { // Subscriptions
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SubscriptionScreen(onNavigateToPayment: () {})),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    String welcomeMessage = authState.isAuthenticated
        ? "Welcome, ${authState.email} 👋"
        : "Welcome to SpatioTrackPlus!";

    return Scaffold(
      backgroundColor: Colors.white, // Set the whole page to white
      appBar: AppBar(
        title: Text(
          welcomeMessage,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.white, // White AppBar
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Sidebar()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: const Center(

      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // White Bottom Navigation Bar
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium),
            label: "Subscriptions",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: "Payment",
          ),
        ],
      ),
    );
  }
}
