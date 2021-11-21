class PlacesModel {
  String id;
  String name;
  String details;
  String description;
  String address;
  List images;
  List price;

  PlacesModel({
    this.id,
    this.name,
    this.images,
    this.description,
    this.details,
    this.address,
    this.price,
  });

  PlacesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    details = json["details"];
    description = json['description'];
    images = json['images'];
    address=json['address'];
    price=json['price'];
  }


}
