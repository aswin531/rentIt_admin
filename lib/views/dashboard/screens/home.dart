import 'package:flutter/material.dart';
import 'package:rent_it_admin_web/utils/colors.dart';
import 'package:rent_it_admin_web/views/dashboard/widgets/cardet_calender.dart';
import 'package:rent_it_admin_web/views/dashboard/widgets/horizaontal_cards.dart';
import 'package:rent_it_admin_web/views/dashboard/widgets/navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body:const Padding(
        padding:  EdgeInsets.all(8.0),
        child: Column(
          children: [
             CustomNavBar(),
             HorizontalCards(),
             HorizontalCardList()
          ],
        ),
      ),
    );
  }
}
