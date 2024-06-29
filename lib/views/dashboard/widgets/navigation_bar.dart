import 'package:flutter/material.dart';
import 'package:rent_it_admin_web/styles/custom_text_styles.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, Admin!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Here is your dashboard', style: CustomTextStyles.caption),
            ],
          ),
          Row(
            children: [
              Container(
                width: 250,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Bell icon
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.black54),
                onPressed: () {
                  // Handle bell icon press
                },
              ),
              const SizedBox(width: 16),
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/dashlogo.jpg'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
