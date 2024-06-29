
import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleCar {
  String? id;
  String? make;
  String? engine;
  String? seatCapacity;
  String? model;
  String? body;
  int? year;
  String? color;
  String? rentalPriceDay;
  bool? status;
  String? mainimageUrl;
  List<String>? imageUrls;

  VehicleCar({
    this.id,
    this.make,
    this.engine,
    this.seatCapacity,
    this.model,
    this.body,
    this.year,
    this.color,
    this.rentalPriceDay,
    this.status,
    this.mainimageUrl,
    this.imageUrls,
  });

//================ Retrieving = Convert a Car from Firestore document================================

  factory VehicleCar.fromFirestore(DocumentSnapshot document) {
    Map data = document.data() as Map<String, dynamic>;

    return VehicleCar(
      id: document.id,
      make: data["make"] ?? "Manufacturer(Toyota)",
      engine: data["engine"] ?? "Petrol",
      seatCapacity: data["seatCapacity"] ?? "5",
      model: data["model"] ?? "Camry",
      body: data["body"] ?? "Sedan",
      year: data["year"] ?? 2024,
      color: data["color"] ?? "White",
      rentalPriceDay: data["rentalPricePerDay"] ?? "2500",
      status: data["status"] ?? "Unavailable",
      mainimageUrl: data["mainimageUrl"] ?? "",
      imageUrls:List<String>.from(data['imageUrls'] ?? []),
    );
  }

//================ Converting = Car to Firestore document================================

  Map<String, dynamic> toFireStoreDocument() {
    return {
      "make": make,
      "engine": engine,
      "seatCapacity": seatCapacity,
      "model": model,
      "body": body,
      "year": year,
      "color": color,
      "rentalPricePerDay": rentalPriceDay,
      "status": status,
      "mainimageUrl": mainimageUrl,
      "imageUrls":imageUrls,
    };
  }
}
