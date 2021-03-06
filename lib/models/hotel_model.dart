// serviceName: serviceName,
// serviceDescripition: serviceDescripition,
// servicePrice: servicePrice,
// servicePhone: servicePhone,
// imagePath:imagePath,
// createdBy: auth.currentUser.email,
// offerd:false,
// offerRatio:null,
// createdAt: new Date(),

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jooy/shared/components/constains.dart';

class HotelModel {
  String Id;
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
  String imagePath;

  int roomNum;
  List usersID;

  HotelModel({
    this.Id,
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
    this.roomNum,
    this.usersID,
  });

  HotelModel.fromJson(Map<String, dynamic> json, [ID]) {

    id = ID;
    Id = json['id'];
    serviceName = json['serviceName'];
    servicePhone = json['servicePhone'];
    servicePrice = json['servicePrice'];
    imagePath = json['imagePath'];
    offerRatio = json['offerRatio'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    offerd = json['offerd'];
    serviceDescripition = json['serviceDescripition'];
    brandName = json['brandName'];
    roomNum = json['roomNumbers'];
    usersID = json['usersID'];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "serviceName": serviceName,
      "servicePhone": servicePhone,
      "servicePrice": servicePrice,
      "imagePath": imagePath,
      "offerRatio": offerRatio,
      "createdAt": createdAt,
      "createdBy": createdBy,
      "offerd": offerd,
      "serviceDescripition": serviceDescripition,
      "brandName": brandName,
      "roomNumbers": roomNum,
      "usersID":usersID,
    };
  }
}
