import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HorizontalCards extends StatelessWidget {
  const HorizontalCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 200,
          minHeight: 100,
          maxHeight: 200,
        ),
        child: Row(
          children: [
            _buildCard(
              title: 'Engine',
              subtitle: 'Subtitle 1',
              icon: Icons.bolt,
              backgroundColor: Colors.blue,
            ),
            _buildCard(
              title: 'Fuel',
              subtitle: 'Subtitle 2',
              icon: FontAwesomeIcons.gasPump,
              backgroundColor: Colors.green,
            ),
            _buildCard(
              title: 'Location',
              subtitle: 'Subtitle 3',
              icon: Icons.location_on_outlined,
              backgroundColor: Colors.orange,
            ),
            _buildCard(
              title: 'Card 4',
              subtitle: 'Subtitle 4',
              icon: Icons.discount_outlined,
              backgroundColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color backgroundColor,
  }) {
    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: backgroundColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   width: 64,
                //   height: 64,
                //   decoration: const BoxDecoration(
                //     color: Colors.white,
                //     shape: BoxShape.circle,
                //   ),
                //   child: Icon(
                //     icon,
                //     size: 32,
                //     color: backgroundColor,
                //   ),
                // ),
                const SizedBox(height: 16.0),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
