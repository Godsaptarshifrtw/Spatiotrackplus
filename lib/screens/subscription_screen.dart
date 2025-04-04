import 'package:flutter/material.dart';
import 'package:spatiotrackplus/screens/payment_screen.dart';
import 'home_screen.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key, required Null Function() onNavigateToPayment});

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int _selectedPlan = 1; // Default: Quarterly Plan
  int _selectedIndex = 1; // Set Subscription as the active tab

  final List<Map<String, dynamic>> plans = [
    {"title": "Monthly", "price": "Rs. 300"},
    {"title": "Quarterly", "price": "Rs. 800", "popular": true},
    {"title": "Yearly", "price": "Rs. 1200"},
  ];

  void _selectPlan(int index) {
    setState(() {
      _selectedPlan = index;
    });
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      return; // Do nothing if tapping the already selected tab
    }

    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  PaymentScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ensures full white background
      appBar: AppBar(



        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Choose the plan that’s right for you",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Subscription Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(plans.length, (index) {
                final plan = plans[index];
                bool isSelected = _selectedPlan == index;

                return GestureDetector(
                  onTap: () => _selectPlan(index),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: 100,
                        height: 120,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: isSelected
                              ? const LinearGradient(
                            colors: [Colors.blue, Colors.purple],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                              : null,
                          border: Border.all(color: Colors.black),
                          color: isSelected ? null : Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              plan["title"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              plan["price"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (plan.containsKey("popular"))
                        Positioned(
                          top: -10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade700,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Most Popular",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),

            const SizedBox(height: 30),

            // Plan Details
            Column(
              children: List.generate(4, (index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Monthly price", style: TextStyle(fontSize: 16)),
                        Text("Rs. 300",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(),
                  ],
                );
              }),
            ),

            const Spacer(),

            // Pay Now Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  PaymentScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Pay now",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Keeps track of the selected tab
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped, // Attach function
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
