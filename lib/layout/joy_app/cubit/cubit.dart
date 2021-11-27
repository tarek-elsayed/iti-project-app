import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    getAllRents();
    getAllHotel();
    getAllRestaurant();
    // showOrderHotels();
    // showOrderRents();
    emit(HomeChangeBottomNavState());
  }

  List<UserModel> userModel = [];

  getAllUsers() {
    FirebaseFirestore.instance.collection("Users").get().then((value) {
      value.docs.forEach((element) {
        userModel.add(UserModel.fromJson(element.data()));
        countUsers = userModel.length;
      });
    });
  }

  UserModel model;

  getUserData() {
    emit(JoyGetUserLoadingStates());
    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data());
      imageUrl = model.image;
      emit(JoyGetUserSuccessStates(model));
    }).catchError((error) {
      emit(JoyGetUserErrorStates(error.toString()));
    });
  }

  void updateUserDate({
    @required String name,
    @required String phone,
    @required String email,
  }) {
    UserModel userModel = UserModel(
      uId: model.uId,
      phone: phone,
      name: name,
      email: email,
      image: imageUrl,
      isEmailVerified: false,
      barcodes: [],
      orderHotels: model.orderHotels,
      orderRent: model.orderRent,
    );

    FirebaseFirestore.instance
        .collection('Users')
        .doc(model.uId)
        .update(userModel.toMap())
        .then((value) {
          print('UpdateUsers');
      getUserData();
    }).catchError((error) {
      emit(JoyErrorUpdateUserImageState());
    });
  }

  List<HotelModel> hotel = [];

  void getAllHotel() {
    hotel = [];
    print("GEt hotel here");
    emit(JoyLoadingGetAllHotelsState());
    FirebaseFirestore.instance
        .collection("Hotels")
        .where('roomNumbers', isGreaterThan: 0)
        .get()
        .then((value) {
      print("hotel");
      print((value));
      value.docs.forEach((element) {
        print("111");
        print(element.id);
        hotel.add(HotelModel.fromJson(element.data()));
      });

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
    restaurant = [];
    FirebaseFirestore.instance.collection("Restaurants").get().then((value) {
      value.docs.forEach((element) {
        restaurant.add(RestaurantModel.fromJson(element.data(), element.id));
      });
      print(restaurant[0].serviceName);
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

  List<RentModel> rent = [];

  void getAllRents() {
    rent = [];
    FirebaseFirestore.instance
        .collection("Rent")
        .where('roomNumbers', isGreaterThan: 0)
        .get()
        .then((value) {
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
    RentID = id;
    emit(JoyLoadingGetRentState());
    FirebaseFirestore.instance.collection("Rent").doc(id).get().then((value) {
      rentModel = RentModel.fromJson(value.data());
      emit(JoySuccessGetRentState(rentModel));

      navigateTo(context, RentDetailScreen(rentModel));
    }).catchError((error) {
      emit(JoyErrorGetRentState(error.toString()));
    });
  }

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

  createSerialNum(ID) {
    serialNum = ID;
    print("serialNumber $serialNum");
    return serialNum;
  }

  generateBarCode(BuildContext context) {
    random = Random().nextDouble() * 555555555555;
    random = (random.toInt() % random).toInt();
    tarek = random;
    print("random ${random.toInt()}");
    return random;
  }

  List<Barcodes> restBarcodes = [];
  Barcodes restBarcode;
  List<Barcodes> restBarcodes1 = [];

  safeBarcode(barCode, serialNum) async {
    // generateBarCode()
    restBarcode = Barcodes(barcode: barCode, serialNum: serialNum);
    if (model.barcodes != null) {
      restBarcodes.add(restBarcode);
    } else {
      model.barcodes = model.barcodes;
    }
    UserModel userModel = UserModel(
      phone: model.phone,
      name: model.name,
      email: model.email,
      image: model.image,
      uId: model.uId,
      isEmailVerified: model.isEmailVerified,
      orderRent: model.orderRent,
      orderHotels: model.orderHotels,
      barcodes: restBarcodes,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) async {
      saveBarcodeRest(random,model.uId);
      print('success');
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
    disableRest = false;
    bookRest = 'Book Now';
    colorRest = Colors.white;
    tarek = null;
    print('CCCC${model.barcodes.length}');
    for (int i = 0; i < model.barcodes.length; i++) {
      if (model.barcodes[i].serialNum == id) {
        if (model.barcodes[i].barcode == null) {
          disableRest = false;
          bookRest = 'Book Now';
          colorRest = Colors.white;
          tarek = null;
          print('BBBB');
        } else {
          disableRest = true;
          bookRest = 'Booked';
          colorRest = Colors.grey[700];
          print('DDDD');
          tarek = model.barcodes[i].barcode;
          break;
        }
      } else {
        disableRest = false;
        bookRest = 'Book Now';
        colorRest = Colors.white;
        print('KKKKKK');
        tarek = null;
      }
    }
  }

  List<Barcodes> barCodeChange = [];

  deleteBarCode(String id) {
    print(id);
    print(model.barcodes.length);
    barCodeChange = [];
    for (int i = 0; i < model.barcodes.length; i++) {
      if (model.barcodes[i].serialNum.toString() == id) {
        print(model.barcodes[i].barcode);
        if (model.barcodes[i].barcode != null) {
          model.barcodes.removeAt(i);
          barCodeChange = model.barcodes;
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
            orderHotels: model.orderHotels,
            orderRent: model.orderRent
          );

          FirebaseFirestore.instance
              .collection("Users")
              .doc(uId)
              .update(userModel.toMap())
              .then((value) {
           getUserData();
            disableRest = false;
            bookRest = 'Book Now';
            colorRest = Colors.white;
            tarek = null;
            print('BBBB');
          });
        }
      }
      print('Lobna111');
    }
  }

  int countRent;
  List<String> orderRentId;

  setBookRent(String id, context) async {
    print("ssss $RentID");
    RentID = id;
    if (rentModel.roomNum != 0) {
      countRent = rentModel.roomNum - 1;
      RentModel VV = RentModel(
        id: RentID,
        servicePhone: rentModel.servicePhone,
        serviceName: rentModel.serviceName,
        offerRatio: rentModel.offerRatio,
        roomNum: countRent,
        offerd: rentModel.offerd,
        brandName: rentModel.brandName,
        imagePath: rentModel.imagePath,
        createdBy: rentModel.createdBy,
        createdAt: rentModel.createdAt,
        serviceDescripition: rentModel.serviceDescripition,
        servicePrice: rentModel.servicePrice,
      );
      FirebaseFirestore.instance
          .collection('Rent')
          .doc(RentID)
          .update(VV.toMap())
          .then((value) async {
        getRent(RentID, context);
        getAllRents();
        for (int i = 0; i < model.orderHotels.length; i++) {
          if (RentID == model.orderHotels[i]) {
            model.orderHotels.add(RentID);
          }
        }
        model.orderRent.add(RentID);
        UserModel user = UserModel(
          uId: model.uId,
          name: model.name,
          email: model.email,
          isEmailVerified: model.isEmailVerified,
          phone: model.phone,
          image: model.image,
          orderHotels: model.orderHotels,
          orderRent: model.orderRent,
          barcodes: model.barcodes,
        );
        FirebaseFirestore.instance
            .collection('Users')
            .doc(uId)
            .update(user.toMap())
            .then((value) {
          disableRent = true;
          bookRent = 'Booked';
          colorRent = Colors.grey[800];
          print('Update Users');
          getUserData();
        });
      });
    }
  }

  int countHotel;
  List<String> orderHotelId;

  setBookHotel(String id, context) {
    print(HotelID);
    HotelID = id;
    if (hotelModel.roomNum != 0) {
      countHotel = hotelModel.roomNum - 1;
      RentModel MM = RentModel(
        id: HotelID,
        servicePhone: hotelModel.servicePhone,
        serviceName: hotelModel.serviceName,
        offerRatio: hotelModel.offerRatio,
        roomNum: countHotel,
        offerd: hotelModel.offerd,
        brandName: hotelModel.brandName,
        imagePath: hotelModel.imagePath,
        createdBy: hotelModel.createdBy,
        createdAt: hotelModel.createdAt,
        serviceDescripition: hotelModel.serviceDescripition,
        servicePrice: hotelModel.servicePrice,
      );
      FirebaseFirestore.instance
          .collection('Hotels')
          .doc(HotelID)
          .update(MM.toMap())
          .then((value) {
        getHotels(HotelID, context);

        print('Count --');
        for (int i = 0; i < model.orderHotels.length; i++) {
          if (HotelID == model.orderHotels[i]) {
            model.orderHotels.add(HotelID);
          }
        }
        model.orderHotels.add(HotelID);

        UserModel user = UserModel(
          uId: model.uId,
          name: model.name,
          email: model.email,
          isEmailVerified: model.isEmailVerified,
          phone: model.phone,
          image: model.image,
          orderHotels: model.orderHotels,
          orderRent: model.orderRent,
          barcodes: model.barcodes,
        );
        FirebaseFirestore.instance
            .collection('Users')
            .doc(uId)
            .update(user.toMap())
            .then((value) {
          print('Update Users');
          getUserData();
        });
      });
    }
  }

  checkRentOrder(String id) {
    print("Id $id");
    for (int j = 0; j < model.orderRent.length; j++) {
      if (model.orderRent[j] == id) {
        print(id);
        print(model.orderRent[j]);
        disableRent = true;
        bookRent = 'Booked';
        colorRent = Colors.grey[800];
        break;
      }
    }
    disableRent = false;
    bookRent = 'Book Now';
    colorRent = Colors.white;
  }

  checkHotelOrder(String id) {
    print("Id $id");
    for (int j = 0; j < model.orderHotels.length; j++) {
      if (model.orderHotels[j] == id) {
        disableHotels = true;
        bookHotels = 'Booked';
        colorHotels = Colors.grey[800];
        break;
      } else {
        disableHotels = false;
        bookHotels = 'Book Now';
        colorHotels = Colors.white;
      }
    }
    disableHotels = false;
    bookHotels = 'Book Now';
    colorHotels = Colors.white;
  }

  List<HotelModel> GetHotels = [];
  List<HotelModel> showHotels = [];

  showOrderHotels() {
    GetHotels = [];
    showHotels = [];
    FirebaseFirestore.instance.collection('Hotels').get().then((value) {
      value.docs.forEach((element) {
        GetHotels.add(HotelModel.fromJson(element.data()));

        // print('true${GetHotels[1].id}');
      });
      print('${GetHotels.length.toInt()} MAMA');
      print('${model.orderHotels.length.toInt()} MAMA');
      for (int i = 0; i < GetHotels.length.toInt(); i++) {
        for (int j = 0; j < model.orderHotels.length.toInt(); j++) {
          if ((model.orderHotels[j].toString()) == GetHotels[i].id) {
            showHotels.add(GetHotels[j]);
          }
        }
      }
      print('BBBB ${showHotels}');
    });
  }

  List<RentModel> GetRents = [];
  List<RentModel> showRent = [];

  showOrderRents() {
    GetRents = [];
    showRent = [];
    FirebaseFirestore.instance.collection('Rent').get().then((value) {
      value.docs.forEach((element) {
        GetRents.add(RentModel.fromJson(element.data()));

        // print('true${GetHotels[1].id}');
      });
      print('${GetRents.length.toInt()} BABA');
      print('${model.orderRent.length.toInt()} BABA');
      for (int i = 0; i < GetRents.length.toInt(); i++) {
        for (int j = 0; j < model.orderRent.length.toInt(); j++) {
          if ((model.orderRent[j].toString()) == GetRents[i].id) {
            showRent.add(GetRents[j]);
          }
        }
      }
      print('RRRR $showRent');
    });
  }

  countService() {
    int x = hotel.length.toInt();
    int y = rent.length.toInt();
    int z = restaurant.length.toInt();

    countServices = x + y + z;
    print('Count $countServices');
  }

  countUser() {
    int x = userModel.length.toInt();

    countUsers = x;
    print('Count $countUsers');
  }

  List<BarcodesRest> barcodesRest = [];
  BarcodesRest barcodeRest;

  saveBarcodeRest(int barcode, String userID) {
    barcodeRest = BarcodesRest(barcode: barcode, userId: userID);
    if (restaurantModel.barcodes != null) {
      barcodesRest.add(barcodeRest);
    } else {
      barcodesRest= restaurantModel.barcodes;
    }
    RestaurantModel restModel = RestaurantModel(
      barcodes: barcodesRest,
      id: restaurantModel.id,
      servicePrice: restaurantModel.servicePrice,
      serviceDescripition: restaurantModel.serviceDescripition,
      createdAt: restaurantModel.createdAt,
      createdBy: restaurantModel.createdBy,
      imagePath: restaurantModel.imagePath,
      brandName: restaurantModel.brandName,
      offerd: restaurantModel.offerd,
      offerRatio: restaurantModel.offerRatio,
      serviceName: restaurantModel.serviceName,
      servicePhone: restaurantModel.servicePhone,
      booked: restaurantModel.booked,
      mealCatgory: restaurantModel.mealCatgory,
    );
    FirebaseFirestore.instance
        .collection("Restaurants")
        .doc(RestID)
        .update(restModel.toMap())
        .then((value) {
          print('Done');
    });
  }


}

/*
RestaurantModel resModel = RestaurantModel(
      id: restaurantModel.id,
      servicePrice: restaurantModel.servicePrice,
      serviceDescripition: restaurantModel.serviceDescripition,
      createdAt: restaurantModel.createdAt,
      createdBy: restaurantModel.createdBy,
      imagePath: restaurantModel.imagePath,
      brandName: restaurantModel.brandName,
      offerd: restaurantModel.offerd,
      offerRatio: restaurantModel.offerRatio,
      serviceName: restaurantModel.serviceName,
      servicePhone: restaurantModel.servicePhone,
      booked: restaurantModel.booked,
      mealCatgory: restaurantModel.mealCatgory,
    );
 */
