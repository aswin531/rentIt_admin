import 'package:flutter/material.dart';
import 'package:rent_it_admin_web/views/category/category.dart';
import 'package:rent_it_admin_web/views/customer/customer.dart';
import 'package:rent_it_admin_web/views/help/help.dart';
import 'package:rent_it_admin_web/views/dashboard/screens/home.dart';
import 'package:rent_it_admin_web/views/logout/logout.dart';
import 'package:rent_it_admin_web/views/rentals/rentals.dart';
import 'package:rent_it_admin_web/views/reviews/reviews.dart';
import 'package:rent_it_admin_web/views/settings/settings.dart';
import 'package:rent_it_admin_web/views/transactions/transactions.dart';
import 'package:rent_it_admin_web/views/vehicles/vehicles.dart';

class SideBarProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  var screens = const [
    HomeScreen(),
    VehicleScreen(),
    CategoryScreen(),
    RentalScreen(),
    ReviewScreen(),
    TransactionsScreen(),
    CustomerScreen(),
    SettingsScreen(),
    HelpScreen(),
    LogoutScreen()
  ];
}
