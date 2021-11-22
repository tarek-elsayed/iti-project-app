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
  });

  RestaurantModel.fromJson(Map<String, dynamic> json, [String ID]) {
    id = ID;
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

  }

  Map<String, dynamic> toMap() {
    return {

    };
  }
}
