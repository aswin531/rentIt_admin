import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_it_admin_web/services/firebase/firebase_auth_services.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthService>(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("LogoutScreen"),
            IconButton(
                onPressed: () async {
                  await authProvider.signOut();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
