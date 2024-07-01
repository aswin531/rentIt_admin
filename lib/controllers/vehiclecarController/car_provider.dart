import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rent_it_admin_web/models/vehicle_model.dart';

class VehicleCarProvider with ChangeNotifier {
  List<Uint8List> _imageFiles = [];
  Uint8List? _mainImageFile;

  List<Uint8List> get imageFiles => _imageFiles;
  Uint8List? get mainImageFile => _mainImageFile;

  String make = "";
  String engine = "";
  int seatCapacity = 0;
  String model = "";
  String body = "";
  int year = 0;
  String color = "";
  String rentalPriceDay = "";
  bool status = false;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> pickImages() async {
    try {
      final result = await FilePicker.platform
          .pickFiles(allowMultiple: true, type: FileType.image);
      if (result != null) {
        _imageFiles = result.files.map((file) => file.bytes!).toList();
        notifyListeners();
      }
    } catch (e) {
      throw 'Failed to pick images: $e';
    }
  }

  Future<void> pickMainImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        _mainImageFile = result.files.single.bytes;
        notifyListeners();
      }
    } catch (e) {
      throw 'Failed to pick main image: $e';
    }
  }

  Future<void> addVehicleCar() async {
    if (_mainImageFile == null || _imageFiles.isEmpty) {
      throw Exception('Please select main and additional images');
    }

    setLoading(true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('Please sign in to upload car details');
      }

      String mainImageUrl = await uploadImage(_mainImageFile!);
      List<String> imageUrls = await uploadImages(_imageFiles);

      VehicleCar vehicleCar = VehicleCar(
        id: "",
        make: make,
        engine: engine,
        seatCapacity: seatCapacity,
        model: model,
        body: body,
        year: year,
        color: color,
        rentalPriceDay: rentalPriceDay,
        status: status,
        mainImageUrl: mainImageUrl,
        imageUrls: imageUrls,
      );

      // Add try-catch block for Firestore write
      try {
        await FirebaseFirestore.instance
            .collection("vehiclecar")
            .add(vehicleCar.toFireStoreDocument());
      } catch (e) {
        throw Exception('Failed to add vehicle details to Firestore: $e');
      }
    } catch (e) {
      throw Exception('Failed to add vehicle car: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<String> uploadImage(Uint8List imageFile) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(
          "vehicleCar_images/${DateTime.now().millisecondsSinceEpoch}.jpg");
      UploadTask uploadTask = ref.putData(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      throw 'Failed to upload image: $e';
    }
  }

  Future<List<String>> uploadImages(List<Uint8List> imageFiles) async {
    List<String> downloadUrls = [];
    for (Uint8List imageFile in imageFiles) {
      String downloadUrl = await uploadImage(imageFile);
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
  }
}


//OLD RULE
// service firebase.storage {
//   match /b/{bucket}/o {
//     match /{allPaths=**} {
//       allow read, write: if false;
//     }
//   }
// }