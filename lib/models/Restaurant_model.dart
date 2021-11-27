// class RestaurantModel {
//   String id;
//   String name;
//   String details;
//   String description;
//   bool fav;
//   List images;
//
//   RestaurantModel({
//     this.id,
//     this.name,
//     this.description,
//     this.details,
//     this.fav,
//     this.images,
//   });
//
//   RestaurantModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     details = json["details"];
//     description = json['description'];
//     fav = json['fav'];
//     images = json['images'];
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       "id": id,
//       "name": name,
//       "details": details,
//       "description": description,
//       "fav": fav,
//       "images": images,
//     };
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  String id;
  String serviceName;
  String servicePhone;
  String servicePrice;
  String serviceDescripition;
  String createdBy;
  bool offerd;
  String offerRatio;
  Timestamp createdAt;
  String brandName;
  //to Do list
  String imagePath ;
  bool booked;
  String mealCatgory;
  List <BarcodesRest> barcodes;


  RestaurantModel({
    this.id,
    this.serviceName,
    this.serviceDescripition,
    this.servicePhone,
    this.imagePath,
    this.servicePrice,
    this.offerRatio,
    this.createdAt,
    this.createdBy,
    this.offerd,
    this.brandName,
    this.booked,
    this.mealCatgory,
    this.barcodes,
  });

  RestaurantModel.fromJson(Map<String, dynamic> json, [String ID]) {
    id = ID;
    // id=json['id'];
    serviceName = json['serviceName'];
    servicePhone = json['servicePhone'];
    servicePrice = json['servicePrice'];
    imagePath = json['imagePath'];
    offerRatio=json['offerRatio'];
    createdAt=json['createdAt'];
    createdBy=json['createdBy'];
    offerd=json['offerd'];
    serviceDescripition=json['serviceDescripition'];
    brandName=json['brandName'];
    booked=json['booked'];
    mealCatgory=json['mealCatgory'];
    if (json['Barcodes'] != null) {
      barcodes = new List<BarcodesRest>() ;
      json['Barcodes'].forEach((v) {
        barcodes.add(new BarcodesRest.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceName'] = this.serviceName;
    data['servicePhone'] = this.servicePhone;
    data['servicePrice'] = this.servicePrice;
    data['imagePath'] = this.imagePath;
    data['offerRatio'] = this.offerRatio;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['offerd']=this.offerd;
    data['serviceDescripition']=this.serviceDescripition;
    data['brandName']=this.brandName;
    data['booked']=this.booked;
    data['mealCatgory']=this.mealCatgory;

    if (this.barcodes != null) {
      data['Barcodes'] = this.barcodes.map((v) => v.toMap()).toList();
    }
    return data;
  }
}
class BarcodesRest {
  String userId;
  int barcode;

  BarcodesRest({this.userId, this.barcode});

  BarcodesRest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    barcode = json['barcode'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serialNum'] = this.userId;
    data['barcode'] = this.barcode;
    return data;
  }
}
