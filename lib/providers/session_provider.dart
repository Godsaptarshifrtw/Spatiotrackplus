import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionState {
  final bool isLoggedIn;
  final String? email;
  final String? token;

  SessionState({this.isLoggedIn = false, this.email, this.token});
}

class SessionNotifier extends StateNotifier<SessionState> {
  SessionNotifier() : super(SessionState()) {
    _loadSession(); // Load session when the provider is created
  }

  // Load session from SharedPreferences
  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final token = prefs.getString('token');

    if (email != null && token != null) {
      state = SessionState(isLoggedIn: true, email: email, token: token);
    }
  }

  // Login function (stores session in SharedPreferences)
  Future<void> login(String email, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('token', token);
    await prefs.setBool('isLoggedIn', true);

    state = SessionState(isLoggedIn: true, email: email, token: token);
  }

  // Logout function (clears session completely)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears all stored session data

    state = SessionState(isLoggedIn: false); // Ensure state is updated
  }
}

// Create Riverpod provider for session management
final sessionProvider = StateNotifierProvider<SessionNotifier, SessionState>(
      (ref) => SessionNotifier(),
);
