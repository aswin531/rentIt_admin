import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';

class VehicleCarProvider with ChangeNotifier {
  final List<File> _imageFiles = [];
  File? _mainImageFile;

  List<File> get imageFiles => _imageFiles;
  File? get mainImageFile => _mainImageFile;

  String make = "";
  String engine = "";
  String seatCapacity = "";
  String model= "";
  String body= "";
  int year= 0;
  String color= "";
  String rentalPriceDay= "";
  bool status= false;
}
