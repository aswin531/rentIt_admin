import 'package:flutter/material.dart';

class HorizontalCardList extends StatelessWidget {
  const HorizontalCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              height: 200, // Example height for demonstration
              child: const Center(
                child: Text('Container 1'),
              ),
            ),
          ),
           const SizedBox(width: 16.0),
          Expanded(
            child: Container(
              color: Colors.black,
              height: 200, // Example height for demonstration
              child: const Center(
                child: Text('Container 2'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
