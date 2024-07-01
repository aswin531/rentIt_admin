import 'package:flutter/material.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Column(
        children: [
          const Text("LogoutScreen"),
          IconButton(onPressed: () {}, icon:const Icon(Icons.logout))
        ],
      ),),
    );
  }
}