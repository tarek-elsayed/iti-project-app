import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jooy/layout/joy_app/cubit/state.dart';
import 'package:jooy/models/Restaurant_model.dart';
import 'package:jooy/models/hotel_model.dart';
import 'package:jooy/models/places_model.dart';
import 'package:jooy/models/rent_model.dart';
import 'package:jooy/models/user_model.dart';
import 'package:jooy/modules/Hotels/hotel_screen.dart';
import 'package:jooy/modules/Rent/rent_screen.dart';
import 'package:jooy/modules/Resturant/resturant_screen.dart';
import 'package:jooy/modules/details_screen/places_datails.dart';
import 'package:jooy/modules/details_screen/rent_details.dart';
import 'package:jooy/modules/details_screen/resturant_details.dart';
import 'package:jooy/modules/details_screen/hotel_details.dart';
import 'package:jooy/modules/place/home_screen.dart';
import 'package:jooy/modules/profile/profile-screen.dart';
import 'package:jooy/shared/components/components.dart';
import 'package:jooy/shared/components/constains.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class JoyCubit extends Cubit<JoyStates> {
  JoyCubit() : super(JoyInitialStates());

  static JoyCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    Place(),
    HotelScreen(),
    ResturantScreen(),
    RentScreen(),
    ProfileScreen()
  ];

  void changeBottom(int index) async {
    currentIndex = index;
    // getFavHotel(FavFromUser,fav);
    // printX();
    getUserData();
    emit(HomeChangeBottomNavState());
  }

  UserModel model;

  void getUserData() async {

    emit(JoyGetUserLoadingStates());
print("USERS $uId");
    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      //value is return as document snapshot
      print(value.data());
      model = UserModel.fromJson(value.data());
      imageUrl = model.image;
      print(model.name);
      print('66666');
      getBarCode(HotelID);
      emit(JoyGetUserSuccessStates(model));
    }).catchError((error) {
      emit(JoyGetUserErrorStates(error.toString()));
    });
  }

  List<HotelModel> hotel = [];

  void getAllHotel() {
    hotel = [];
    print("GEt hotel here");
    emit(JoyLoadingGetAllHotelsState());
    FirebaseFirestore.instance.collection("Hotels").get().then((value) {
      print("hotel");
      print((value));
      value.docs.forEach((element) {
        print("111");
        print(element.id);
        hotel.add(HotelModel.fromJson(element.data(), element.id));
      });
      // fav = hotel;
      // print("hotellll");
      // print(fav);

      emit(JoySuccessGetAllHotelsState());
    }).catchError((error) {
      emit(JoyErrorGetAllHotelsState(error.toString()));
    });
  }

  HotelModel hotelModel;

  void getHotels(id, context) {
    // HotelID = id;
    print("LLL");
    print(id);
    emit(JoyLoadingGetHotelsState());

    FirebaseFirestore.instance.collection("Hotels").doc(id).get().then((value) {
      hotelModel = HotelModel.fromJson(value.data());
      emit(JoySuccessGetHotelsState(hotelModel));
      navigateTo(context, HotelDetailScreen(hotelModel, model));
    }).catchError((error) {
      emit(JoyErrorGetHotelsState(error.toString()));
    });
  }

  List<RestaurantModel> restaurant = [];

  void getAllRestaurant() {
    FirebaseFirestore.instance.collection("Restaurants").get().then((value) {
      value.docs.forEach((element) {
        restaurant.add(RestaurantModel.fromJson(element.data(), element.id));
        print("111");
      });

      print("Restaurantttttttt");
      print(restaurant[0].serviceName);
      print("Restaurantttttttt");
      print(restaurant[0].serviceDescripition);
      emit(JoySuccessGetAllRestaurantState());
    }).catchError((error) {
      emit(JoyErrorGetAllRestaurantState(error.toString()));
    });
  }

  RestaurantModel restaurantModel;

  void getRestaurant(id, context) {
    emit(JoyLoadingGetRestaurantState());
    FirebaseFirestore.instance
        .collection("Restaurants")
        .doc(id)
        .get()
        .then((value) {
      restaurantModel = RestaurantModel.fromJson(value.data());
      emit(JoySuccessGetRestaurantState(restaurantModel));
      navigateTo(context, RestaurantDetailScreen(restaurantModel));
    }).catchError((error) {
      emit(JoyErrorGetRestaurantState(error.toString()));
    });
  }

  // changeFav(id) {
  //   if (hotelModel.fav) {
  //     hotelModel.fav = false;
  //   }
  // }

  // void updateHotel({
  //   @required String id,
  //   @required String hotelName,
  //   @required String details,
  //   @required String description,
  //   @required List images,
  //   @required bool fav,
  // }) {
  //   emit(JoySetHotelFavouritesState());
  //   // HotelModel model = HotelModel(
  //   //     id: id,
  //   //     description: description,
  //   //     details: details,
  //   //     hotelName: hotelName,
  //   //     images: images,
  //   //     fav: fav);
  //   print("Model11");
  //   // print(model.fav);
  //   FirebaseFirestore.instance
  //       .collection("Hotels")
  //       .doc(id)
  //       .update(model.toMap())
  //       .then((value) {
  //     emit(JoySetHotelFavouritesSuccessState());
  //     getAllHotel();
  //   }).catchError(onError);
  // }

  // void updateRest({
  //   @required String name,
  //   @required String id,
  //   @required String details,
  //   @required String description,
  //   @required List images,
  //   @required bool fav,
  // }) {
  //   emit(JoySetRestaurantFavouritesState());
  //   // RestaurantModel model = RestaurantModel(
  //   //     id: id,
  //   //     description: description,
  //   //     details: details,
  //   //     name: name,
  //   //     images: images,
  //   //     fav: fav);
  //   print("Model11");
  //   // print(model.fav);
  //   FirebaseFirestore.instance
  //       .collection("Restaurants")
  //       .doc(id)
  //       .update(model.toMap())
  //       .then((value) {
  //     emit(JoySetRestaurantFavouritesSuccessState());
  //     getAllHotel();
  //   }).catchError(onError);
  // }

  File profileImage;
  var picker = ImagePicker();

  Future<void> getImage(String name, String phone, String email) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print('sssss');
      print(profileImage.path);
      uploadImage();
      updateUserDate(name: name, phone: phone, email: email);
      emit(JoySuccessProfileImageState());
    } else {
      print('No Image Selected');
      emit(JoyErrorProfileImageState());
    }
  }

  String imageUrl = '';

  void uploadImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(JoySuccessUplodeProfileImageState());
        imageUrl = value;
      }).catchError((error) {
        print("Error");
        emit(JoyErrorUplodeProfileImageState());
      });
    }).catchError((error) {
      emit(JoyErrorUplodeProfileImageState());
    });
  }

  void updateUserDate({
    @required String name,
    @required String phone,
    @required String email,
  }) {
    UserModel userModel = UserModel(
      phone: phone,
      name: name,
      email: email,
      image: imageUrl,
      uId: model.uId,
      isEmailVerified: false,
      barcodes: model.barcodes
    );

    // if(profileImage!= null){
    //   uploadImage();
    // }
    // else{
    FirebaseFirestore.instance
        .collection('Users')
        .doc(model.uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(JoyErrorUpdateUserImageState());
    });
    // }
    // FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(model.uId)
    //     .update(model.toMap())
    //     .then((value) {
    //   getUserData();
    // }).catchError((error) {
    //   emit(JoyErrorUpdateUserImageState());
    // });
  }

  List<PlacesModel> places = [];

  void getAllPlaces() {
    places = [];
    emit(JoyLoadingGetAllPlacesState());
    FirebaseFirestore.instance.collection('Places').get().then((value) {
      value.docs.forEach((element) {
        places.add(PlacesModel.fromJson(element.data()));

        emit(JoySuccessGetAllPlacesState());
      });
      print('places');
      print(places[0].name);
    }).catchError((error) {
      emit(JoyErrorGetAllPlacesState(error.toString()));
    });
  }

  PlacesModel place;

  void getPlace(id, BuildContext context) {
    emit(JoyLoadingGetPlacesState());
    FirebaseFirestore.instance.collection('Places').doc(id).get().then((value) {
      place = PlacesModel.fromJson(value.data());
      navigateTo(context, PlaceScreen(place));
      emit(JoySuccessGetPlacesState(place));
      print("image");
      print(place.images);
    }).catchError((error) {
      emit(JoyErrorGetPlacesState(error.toString()));
    });
  }

  // List<HotelModel> Fav;
  // List<HotelModel> fav;
  // List FavFromUser = [];
  //
  // void getFavHotel(List FavFromUser, List<HotelModel> fav) {
  //   for (int i = 0; i < fav.length; i++) {
  //     for (int j = 0; j < FavFromUser.length; j++) {
  //       if (FavFromUser[j] == fav[i].id) {
  //         Fav.add(fav[j]);
  //         print('FFF');
  //         print(Fav);
  //       }
  //     }
  //   }
  // }

  List<RentModel> rent = [];

  void getAllRents() {
    FirebaseFirestore.instance.collection("Rent").get().then((value) {
      value.docs.forEach((element) {
        rent.add(RentModel.fromJson(element.data(), element.id));
      });

      print("Rentttttttt");
      print(rent[0].serviceName);
      emit(JoySuccessGetAllRestaurantState());
    }).catchError((error) {
      emit(JoyErrorGetAllRestaurantState(error.toString()));
    });
  }

  RentModel rentModel;

  void getRent(id, context) {
    emit(JoyLoadingGetRentState());
    FirebaseFirestore.instance.collection("Rent").doc(id).get().then((value) {
      rentModel = RentModel.fromJson(value.data());
      emit(JoySuccessGetRentState(rentModel));
      navigateTo(context, RentDetailScreen(rentModel));
    }).catchError((error) {
      emit(JoyErrorGetRentState(error.toString()));
    });
  }

  createSerialNum(ID) {
    serialNum = ID;
    print("serialNumber $serialNum");
    return serialNum;
  }

  generateBarCode(BuildContext context) {
    random = Random().nextDouble() * 555555555555;
    random = (random.toInt() % random).toInt();
    tarek=random;
    print("random ${random.toInt()}");
    return random;
  }

  List<Barcodes> hotelBarcodes = [];
  Barcodes hotelBarcode;
  List<Barcodes> hotelBarcodes1 = [];

  safeBarcode(barCode, SerialNum) async {
    // generateBarCode()
    hotelBarcode = Barcodes(barcode: barCode, serialNum: SerialNum);
    if (model.barcodes != null) {
      hotelBarcodes.add(hotelBarcode);
    } else {
      model.barcodes = model.barcodes;
    }
    // z.add(x);
    UserModel userModel = UserModel(
      phone: model.phone,
      name: model.name,
      email: model.email,
      image: model.image,
      uId: model.uId,
      isEmailVerified: model.isEmailVerified,
      barcodes: hotelBarcodes,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) async {
      updateUserDate(name: model.name, phone: model.phone, email: model.email);

      // await getBarCode(SerialNum);
      // showBarcode(serialNum);
    });
  }

  getBarCode(String id) {
    int barcode;
    for (int i = 0; i < model.barcodes.length; i++) {
      if (model.barcodes[i].serialNum == id) {
        barcode = model.barcodes[i].barcode;
        tarek = barcode;
        print('&&&& $barcode');
      }
    }
    return barcode;
  }

  checkBarcode(String id) {
    disable = false;
    book = 'Book Now';
    color = Colors.white;
    tarek=null;
    for (int i = 0; i < model.barcodes.length; i++) {
      if (model.barcodes[i].serialNum == id) {
        if (model.barcodes[i].barcode == null) {
          disable = false;
          book = 'Book Now';
          color = Colors.white;
          tarek=null;
          print('BBBB');
        }
        else {
          disable = true;
          book = 'Booked';
          color = Colors.grey[300];
          print('DDDD');
          tarek=model.barcodes[i].barcode;
          break;
        }
      }
       else {
        disable = false;
        book = 'Book Now';
        color = Colors.white;
        print('KKKKKK');
        tarek = null;
      }
    }
  }
List<Barcodes> barCodeChange = [];
  deleteBarCode(String id){
    print(id);
    print(model.barcodes.length);
    barCodeChange=[];
    for(int i =0; i<model.barcodes.length; i++){
      if (model.barcodes[i].serialNum == id) {
        print(model.barcodes[i].barcode);
        if (model.barcodes[i].barcode != null) {
         model.barcodes.removeAt(i);
         barCodeChange=model.barcodes;
          print('Lobna');
          print(model.barcodes.length);
          print(model.barcodes);
          UserModel userModel = UserModel(
            phone: model.phone,
            name: model.name,
            email: model.email,
            image: model.image,
            uId: model.uId,
            isEmailVerified: model.isEmailVerified,
            barcodes: barCodeChange,
          );
          FirebaseFirestore.instance.collection("Users").doc(uId)
              .update(userModel.toMap()).then((value){
            updateUserDate(name: model.name, phone: model.phone, email: model.email);
            disable = false;
            book = 'Book Now';
            color = Colors.white;
            tarek=null;
            print('BBBB');
          });
        }
      }
      print('Lobna111');
    }
  }


}
