
// Future<String> uploadImage(html.File imageFile) async {
//   FirebaseStorage storage = FirebaseStorage.instance;
//   Reference ref = storage.ref().child('car_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
//   UploadTask uploadTask = ref.putBlob(imageFile);
//   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
//   return await taskSnapshot.ref.getDownloadURL();
// }



// Future<void> addCar(Car car, File imageFile) async {
//   try {
//     // Upload the image to Firebase Storage
//     String imageUrl = await uploadImage(imageFile);

//     // Update car's imageUrl
//     car = Car(
//       id: car.id,
//       make: car.make,
//       model: car.model,
//       year: car.year,
//       color: car.color,
//       rentalPricePerDay: car.rentalPricePerDay,
//       isAvailable: car.isAvailable,
//       imageUrl: imageUrl,
//     );

//     // Add the car to Firestore
//     await FirebaseFirestore.instance.collection('cars').add(car.toFirestore());
//     print('Car added successfully');
//   } catch (e) {
//     print('Error adding car: $e');
//   }
// }



// Stream<List<Car>> getCars() {
//   return FirebaseFirestore.instance.collection('cars').snapshots().map((QuerySnapshot query) {
//     return query.docs.map((doc) {
//       return Car.fromFirestore(doc);
//     }).toList();
//   });
// }



// ========. Upload Multiple Images to Firebase Storage====================
// **********Create a function to upload multiple images and return their download URLs.**************

// Future<List<String>> uploadImages(List<File> imageFiles) async {
//   FirebaseStorage storage = FirebaseStorage.instance;
//   List<String> downloadUrls = [];

//   for (File imageFile in imageFiles) {
//     Reference ref = storage.ref().child('car_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
//     UploadTask uploadTask = ref.putFile(imageFile);
//     TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
//     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//     downloadUrls.add(downloadUrl);
//   }

//   return downloadUrls;
// }


// ============= Example Usage in Admin Web App================================
// *****************Here’s an example of how you can integrate this in your admin web app. This example assumes you are using Flutter Web for the admin interface.***************************

// dart
// Copy code
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'car.dart'; // Import the Car model
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Car Rental Admin'),
//         ),
//         body: CarForm(),
//       ),
//     );
//   }
// }

// class CarForm extends StatefulWidget {
//   @override
//   _CarFormState createState() => _CarFormState();
// }

// class _CarFormState extends State<CarForm> {
//   final picker = ImagePicker();
//   List<File> _imageFiles = [];
//   File? _mainImageFile;

//   final _formKey = GlobalKey<FormState>();
//   String make = '';
//   String model = '';
//   int year = 0;
//   String color = '';
//   double rentalPricePerDay = 0.0;
//   bool isAvailable = true;

//   Future<void> pickImages() async {
//     final pickedFiles = await picker.pickMultiImage();
//     if (pickedFiles != null) {
//       setState(() {
//         _imageFiles = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
//       });
//     }
//   }

//   Future<void> pickMainImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _mainImageFile = File(pickedFile.path);
//       });
//     }
//   }

//   void submitForm() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       Car car = Car(
//         id: '',
//         make: make,
//         model: model,
//         year: year,
//         color: color,
//         rentalPricePerDay: rentalPricePerDay,
//         isAvailable: isAvailable,
//         mainImageUrl: '',
//         imageUrls: [],
//       );

//       addCar(car, _imageFiles, _mainImageFile!);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: ListView(
//           children: [
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Make'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the make';
//                 }
//                 return null;
//               },
//               onSaved: (value) {
//                 make = value!;
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Model'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the model';
//                 }
//                 return null;
//               },
//               onSaved: (value) {
//                 model = value!;
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Year'),
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the year';
//                 }
//                 return null;
//               },
//               onSaved: (value) {
//                 year = int.parse(value!);
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Color'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the color';
//                 }
//                 return null;
//               },
//               onSaved: (value) {
//                 color = value!;
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Rental Price Per Day'),
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the rental price per day';
//                 }
//                 return null;
//               },
//               onSaved: (value) {
//                 rentalPricePerDay = double.parse(value!);
//               },
//             ),
//             SwitchListTile(
//               title: Text('Available'),
//               value: isAvailable,
//               onChanged: (value) {
//                 setState(() {
//                   isAvailable = value;
//                 });
//               },
//             ),
//             ElevatedButton(
//               onPressed: pickMainImage,
//               child: Text('Pick Main Image'),
//             ),
//             ElevatedButton(
//               onPressed: pickImages,
//               child: Text('Pick Additional Images'),
//             ),
//             ElevatedButton(
//               onPressed: submitForm,
//               child: Text('Add Car'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Future<String> uploadImage(File imageFile) async {
//   FirebaseStorage storage = FirebaseStorage.instance;
//   Reference ref = storage.ref().child('car_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
//   UploadTask uploadTask =