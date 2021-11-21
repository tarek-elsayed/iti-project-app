
import 'package:cloud_firestore/cloud_firestore.dart';

class RentModel {
  String id;
  String serviceName;
  String servicePhone;
  String servicePrice;
  String serviceDescripition;
  String createdBy;
  bool offerd;
  String offerRatio;
  Timestamp createdAt;
  //to Do list
  String imagePath ;


  RentModel({
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
  });

  RentModel.fromJson(Map<String, dynamic> json, [String ID]) {
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

  }

  Map<String, dynamic> toMap() {
    return {

    };
  }
}
