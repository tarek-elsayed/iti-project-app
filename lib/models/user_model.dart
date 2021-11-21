

class UserModel {
  String name;
  String email;
  String phone;
  String uId;
  String image;
  bool isEmailVerified;
  List favHotel;

  UserModel({
    this.name,
    this.uId,
    this.email,
    this.phone,
    this.isEmailVerified,
    this.image,
    this.favHotel,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
    favHotel=json['favHotel'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "phone": phone,
      "email": email,
      "uId": uId,
      "isEmailVerified": isEmailVerified,
      'image': image,
      'favHotel':favHotel,
    };
  }
}
