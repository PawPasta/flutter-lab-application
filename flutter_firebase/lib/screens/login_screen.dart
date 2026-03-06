import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final userCredential = await authService.signInWithGoogle();

            if (userCredential != null) {
              final user = userCredential.user;

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      HomeScreen(userName: user?.displayName ?? "User"),
                ),
              );
            }
          },
          child: const Text("Sign in with Google"),
        ),
      ),
    );
  }
}
