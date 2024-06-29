import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_it_admin_web/controllers/vehiclecarController/car_provider.dart';
import 'package:rent_it_admin_web/utils/error_widgets.dart';
import 'package:rent_it_admin_web/utils/loading_indicator.dart';


class CarForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  CarForm({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleCarProvider = Provider.of<VehicleCarProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Stack(
          children: [
            ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Make'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the make';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    vehicleCarProvider.make = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Model'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the model';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    vehicleCarProvider.model = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Year'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the year';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    vehicleCarProvider.year = int.parse(value!);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Color'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the color';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    vehicleCarProvider.color = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Rental Price Per Day'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the rental price per day';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    vehicleCarProvider.rentalPriceDay = value!;
                  },
                ),
                SwitchListTile(
                  title: const Text('Available'),
                  value: vehicleCarProvider.status,
                  onChanged: (value) {
                    vehicleCarProvider.status = value;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await vehicleCarProvider.pickMainImage();
                    } catch (e) {
                      await showErrorDialog(context, e.toString());
                    }
                  },
                  child: const Text('Pick Main Image'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await vehicleCarProvider.pickImages();
                    } catch (e) {
                      await showErrorDialog(context, e.toString());
                    }
                  },
                  child: const Text('Pick Additional Images'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      try {
                        await vehicleCarProvider.addVehicleCar();
                      } catch (e) {
                        await showErrorDialog(context, e.toString());
                      }
                    }
                  },
                  child: const Text('Add Car'),
                ),
              ],
            ),
            if (vehicleCarProvider.isLoading) 
              const LoadingIndicator(), // Show the loading indicator when loading
          ],
        ),
      ),
    );
  }
}
