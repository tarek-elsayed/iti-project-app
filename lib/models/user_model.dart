//
//
// class UserModel {
//   String name;
//   String email;
//   String phone;
//   String uId;
//   String image;
//   bool isEmailVerified;
//
//
//   UserModel({
//     this.name,
//     this.uId,
//     this.email,
//     this.phone,
//     this.isEmailVerified,
//     this.image,
//
//   });
//
//   UserModel.fromJson(Map<String, dynamic> json) {
//     email = json['email'];
//     name = json['name'];
//     phone = json['phone'];
//     uId = json['uId'];
//     isEmailVerified = json['isEmailVerified'];
//     image = json['image'];
//
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       "name": name,
//       "phone": phone,
//       "email": email,
//       "uId": uId,
//       "isEmailVerified": isEmailVerified,
//       'image': image,
//
//     };
//   }
// }
class UserModel {
  String uId;
  String email;
  bool isEmailVerified;
  String name;
  String image;
  String phone;
  List<Barcodes> barcodes;

  UserModel(
      {this.uId,
        this.email,
        this.isEmailVerified,
        this.name,
        this.image,
        this.phone,
        this.barcodes});

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    if (json['Barcodes'] != null) {
      barcodes = new List<Barcodes>();
      json['Barcodes'].forEach((v) {
        barcodes.add(new Barcodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uId'] = this.uId;
    data['email'] = this.email;
    data['isEmailVerified'] = this.isEmailVerified;
    data['name'] = this.name;
    data['image'] = this.image;
    data['phone'] = this.phone;
    if (this.barcodes != null) {
      data['Barcodes'] = this.barcodes.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class Barcodes {
  String serialNum;
  int barcode;

  Barcodes({this.serialNum, this.barcode});

  Barcodes.fromJson(Map<String, dynamic> json) {
    serialNum = json['serialNum'];
    barcode = json['barcode'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serialNum'] = this.serialNum;
    data['barcode'] = this.barcode;
    return data;
  }
}