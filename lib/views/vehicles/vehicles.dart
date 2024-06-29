import 'package:flutter/material.dart';
import 'package:rent_it_admin_web/views/vehicles/vehicle_car_regform.dart';

class VehicleScreen extends StatelessWidget {
  const VehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: CarForm(),
      ),
    );
  }
}
